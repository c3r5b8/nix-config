#!/usr/bin/env bash
#
# Build all NixOS host configurations before and after a flake update,
# then report per-host package diffs via nvd.
#
# Exit codes:
# 0 — success + at least one host has closure changes
# 1 — build failure (or other error)
# 2 — flake.lock did not change
# 3 — flake.lock changed but no closures differ

set -euo pipefail

SKIP_UPDATE=false
for arg in "$@"; do
  case "$arg" in
    --skip-update) SKIP_UPDATE=true ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

# Helpers
log() { echo " $*" >&2; }
ok() { echo " ✓ $*" >&2; }
fail() { echo " ✗ $*" >&2; }

if [ -n "${CI:-}" ]; then
  step() { echo "::group::$1" >&2; }
  endstep() { echo "::endgroup::" >&2; }
else
  step() { echo >&2; echo "── $1 ──" >&2; }
  endstep() { :; }
fi

# ---------------------------------------------------------------------------
# Build helper with separate stdout/stderr + clean error reporting
# ---------------------------------------------------------------------------
build_host() {
  local phase="$1"     # "current" or "updated"
  local host="$2"

  local out_log="build-${phase}-${host}.stdout.log"
  local err_log="build-${phase}-${host}.stderr.log"

  step "Building ${phase} $host"

  if ! nix build ".#nixosConfigurations.$host.config.system.build.toplevel" \
       -o "result-${phase}-$host" \
       > >(tee "$out_log") 2> >(tee "$err_log" >&2); then

    fail "Failed to build ${phase} $host"

    # Create clean error report for GitHub Issue
    {
      echo "### ❌ Build failed for host: \`$host\` (${phase})"
      echo ""
      echo "**stderr (last 80 lines):**"
      echo '```'
      tail -n 80 "$err_log" 2>/dev/null || cat "$err_log"
      echo '```'
      echo ""
      echo "**stdout (last 30 lines):**"
      echo '```'
      tail -n 30 "$out_log" 2>/dev/null || true
      echo '```'
      echo ""
      echo "Full logs are available as workflow artifacts."
    } > error-report.md

    exit 1
  fi

  endstep
}

# 1. Discover hosts
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

# 2. Build current configurations
for host in $HOSTS; do
  build_host "current" "$host"
done

# 3. Update flake
if [ "$SKIP_UPDATE" = false ]; then
  step "Updating flake inputs"
  nix flake update
  endstep
fi

# 4. Check flake.lock
step "Checking for flake.lock changes"
if git diff --quiet flake.lock 2>/dev/null; then
  ok "No changes — nothing to do."
  endstep
  exit 2
fi
ok "flake.lock changed, rebuilding hosts."
endstep

# 5. Build updated + diffs
DIFF_REPORT=""
HAS_CHANGES=false
CHANGED_HOSTS=""
UNCHANGED_HOSTS=""

for host in $HOSTS; do
  build_host "updated" "$host"

  if [ -e "result-current-$host" ] && [ -e "result-updated-$host" ]; then
    step "Package diff for $host"
    HOST_DIFF=$(nix run nixpkgs#nvd -- diff "result-current-$host" "result-updated-$host" 2>&1 || true)
    echo "$HOST_DIFF" >&2
    endstep

    if [ "$(readlink "result-current-$host")" != "$(readlink "result-updated-$host")" ]; then
      HAS_CHANGES=true
      CHANGED_HOSTS="$CHANGED_HOSTS $host"
      DIFF_REPORT="${DIFF_REPORT}### ${host}\n\`\`\`\n${HOST_DIFF}\n\`\`\`\n\n"
    else
      UNCHANGED_HOSTS="$UNCHANGED_HOSTS $host"
    fi
  fi
done

# 6. Summary
step "Summary"
if [ -n "$CHANGED_HOSTS" ]; then ok "Changed: $CHANGED_HOSTS"; fi
if [ -n "$UNCHANGED_HOSTS" ]; then log "Unchanged: $UNCHANGED_HOSTS"; fi

if [ "$HAS_CHANGES" = false ]; then
  fail "flake.lock changed but no host closures differ."
  endstep
  exit 3
fi

ok "Done — diff report ready."
endstep

printf '%s' "$DIFF_REPORT"
