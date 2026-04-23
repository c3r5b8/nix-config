{
  config,
  pkgs,
  ...
}: {
  system.autoUpgrade = {
    enable = true;
    flake = "github:c3r5b8/nix-config#${config.networking.hostName}";
    flags = ["--no-update-lock-file"];
    dates = "05:00";
    allowReboot = false;
    operation = "switch";

    persistent = true;
  };
  systemd.services.nixos-upgrade = {
    preStart = let
      preStartScript = pkgs.writeShellScript "nixos-upgrade-prestart" ''
        #!/usr/bin/env bash
        set -euo pipefail

        echo "=== nixos-upgrade pre-start checks ==="

        LOCAL_REPO="/home/c3r5b8/dev/nix-config"

        if [ -d "$LOCAL_REPO/.git" ]; then
          if su -s /bin/sh -c "cd '$LOCAL_REPO' && git status --porcelain | grep -q . " c3r5b8; then
            echo "nixos-upgrade: Local repo at $LOCAL_REPO is DIRTY"
            echo "               (you have uncommitted changes)"
            exit 0
          fi
        else
          echo "nixos-upgrade: No git repo found at $LOCAL_REPO"
        fi

        timeout=43200

        while ! ${pkgs.systemd}/bin/systemd-ac-power; do
          sleep 30
          timeout=$((timeout - 30))
          if [ "$timeout" -le 0 ]; then
            echo "nixos-upgrade: Timeout waiting for AC power — skipping upgrade today"
            exit 0
          fi
        done

        echo "nixos-upgrade: AC power detected — all checks passed. Starting upgrade!"
      '';
    in "${preStartScript}";
  };
}
