#!/usr/bin/env bash
#
# Build all NixOS host configurations before and after a flake update,
# then report per-host package diffs via nvd.
#
# Exit codes:
#   0 — at least one host has closure changes (diff report on stdout)
#   1 — unexpected error
#   2 — flake.lock did not change after update
#   3 — flake.lock changed but no host closures differ
#
# Options:
#   --skip-update   Skip 'nix flake update' (useful when flake.lock is
#                   already updated and you just want to diff)
#
set -euo pipefail

SKIP_UPDATE=false
for arg in "$@"; do
  case "$arg" in
    --skip-update) SKIP_UPDATE=true ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
log()   { echo "  $*" >&2; }
ok()    { echo "  ✓ $*" >&2; }
fail()  { echo "  ✗ $*" >&2; }
# In CI: use ::group::/::endgroup:: for collapsible sections.
# Locally: print readable section headers instead.
if [ -n "${CI:-}" ]; then
  step()     { echo "::group::$1" >&2; }
  endstep()  { echo "::endgroup::" >&2; }
else
  step()     { echo >&2; echo "── $1 ──" >&2; }
  endstep()  { :; }
fi

# ---------------------------------------------------------------------------
# 1. Discover full (non-minimal) host configurations
# ---------------------------------------------------------------------------
step "Discovering hosts"
HOSTS=$(nix eval .#nixosConfigurations \
  --apply 'cs: builtins.filter (n: builtins.match ".*-minimal" n == null) (builtins.attrNames cs)' \
  --json | nix run nixpkgs#jq -- -r '.[]')

if [ -z "$HOSTS" ]; then
  fail "No host configurations found."
  exit 1
fi
HOST_COUNT=$(echo "$HOSTS" | wc -w | tr -d ' ')
log "Found $HOST_COUNT host(s): $(echo "$HOSTS" | tr '\n' ' ')"
endstep

# ---------------------------------------------------------------------------
# 2. Build current (before-update) configurations
# ---------------------------------------------------------------------------
for host in $HOSTS; do
  step "Building current $host"
  nix build ".#nixosConfigurations.$host.config.system.build.toplevel" \
    -o "result-before-$host" || true
  endstep
done

# ---------------------------------------------------------------------------
# 3. Update flake inputs
# ---------------------------------------------------------------------------
if [ "$SKIP_UPDATE" = false ]; then
  step "Updating flake inputs"
  nix flake update
  endstep
fi

# ---------------------------------------------------------------------------
# 4. Check whether flake.lock actually changed
# ---------------------------------------------------------------------------
step "Checking for flake.lock changes"
if git diff --quiet flake.lock 2>/dev/null; then
  ok "No changes — nothing to do."
  endstep
  exit 2
fi
ok "flake.lock has changed, rebuilding hosts."
endstep

# ---------------------------------------------------------------------------
# 5. Build updated configurations and generate per-host diffs
# ---------------------------------------------------------------------------
DIFF_REPORT=""
HAS_CHANGES=false
CHANGED_HOSTS=""
UNCHANGED_HOSTS=""

for host in $HOSTS; do
  step "Building updated $host"
  nix build ".#nixosConfigurations.$host.config.system.build.toplevel" \
    -o "result-after-$host" || true
  endstep

  if [ -e "result-before-$host" ] && [ -e "result-after-$host" ]; then
    step "Package diff for $host"
    HOST_DIFF=$(nix run nixpkgs#nvd -- diff "result-before-$host" "result-after-$host" 2>&1 || true)
    echo "$HOST_DIFF" >&2
    endstep

    if [ "$(readlink "result-before-$host")" != "$(readlink "result-after-$host")" ]; then
      HAS_CHANGES=true
      CHANGED_HOSTS="$CHANGED_HOSTS $host"
      DIFF_REPORT="${DIFF_REPORT}### ${host}"$'\n'"\`\`\`"$'\n'"${HOST_DIFF}"$'\n'"\`\`\`"$'\n\n'
    else
      UNCHANGED_HOSTS="$UNCHANGED_HOSTS $host"
    fi
  fi
done

# ---------------------------------------------------------------------------
# 6. Report results
# ---------------------------------------------------------------------------
step "Summary"
if [ -n "$CHANGED_HOSTS" ]; then
  ok "Changed:  $CHANGED_HOSTS"
fi
if [ -n "$UNCHANGED_HOSTS" ]; then
  log "Unchanged:$UNCHANGED_HOSTS"
fi

if [ "$HAS_CHANGES" = false ]; then
  fail "flake.lock changed but no host closures differ."
  endstep
  exit 3
fi

ok "Done — diff report ready."
endstep

# Print the diff report to stdout for consumers (CI, local review, etc.)
printf '%s' "$DIFF_REPORT"
