{config, ...}: {
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
    unitConfig.ConditionACPower = true;
  };
}
