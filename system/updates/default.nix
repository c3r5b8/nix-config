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
      waitForAC = pkgs.writeShellScript "wait-for-ac-power" ''
        #!/usr/bin/env bash
        set -euo pipefail

        echo "nixos-upgrade: Checking AC power..."

        timeout=43200

        while ! ${pkgs.systemd}/bin/systemd-ac-power; do
          echo "nixos-upgrade: On battery — waiting 120s for AC power..."
          sleep 120
          timeout=$((timeout - 120))
          if [ "$timeout" -le 0 ]; then
            echo "nixos-upgrade: Timeout waiting for AC power — skipping upgrade today"
            exit 1
          fi
        done

        echo "nixos-upgrade: AC power detected — proceeding with upgrade!"
      '';
    in "${waitForAC}";
  };
}
