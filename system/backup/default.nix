{
  config,
  pkgs,
  ...
}: {
  sops.secrets.resticEnv = {};
  sops.secrets.resticPass = {};
  services.restic.backups.persist = {
    initialize = true;
    repository = "s3:s3.eu-central-003.backblazeb2.com/nixos-backup-c3r5b8/${config.networking.hostName}";
    environmentFile = config.sops.secrets.resticEnv.path;
    passwordFile = config.sops.secrets.resticPass.path;
    paths = ["/persist"];
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 6"
    ];
    extraBackupArgs = ["--one-file-system" "--exclude-caches"];
    timerConfig = {
      OnCalendar = "*-*-* 05:00:00";
      Persistent = true;
    };
  };
  systemd.services.restic-backups-persist = {
    preStart = let
      preStartScript = pkgs.writeShellScript "restic-backups-persist-prestart" ''
        #!/usr/bin/env bash
        set -euo pipefail

        timeout=43200

        while ! ${pkgs.systemd}/bin/systemd-ac-power; do
          sleep 30
          timeout=$((timeout - 30))
          if [ "$timeout" -le 0 ]; then
            echo "restic-backups-persist: Timeout waiting for AC power — skipping backup today"
            exit 0
          fi
        done

        echo "restic-backups-persist: AC power detected — all checks passed. Starting backup!"
      '';
    in "${preStartScript}";
  };
}
