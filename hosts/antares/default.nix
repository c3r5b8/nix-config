{ pkgs, inputs, config, ... }:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-laptop

    ./hardware-configuration.nix

    ../common/global
    ../common/users/c3r5b8

    ../common/optional/quietboot.nix
  ];
  networking = {
    hostName = "antares";
    # useDHCP = true;
  };
  environment.etc.testsops.text = config.sops.secrets.c3r5b8_pass.path;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  # home-manager.users.c3r5b8 = import ../../home/c3r5b8/antares.nix;

  services.gnome.gnome-keyring.enable = true;
  security.sudo.wheelNeedsPassword = false;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  networking.networkmanager.enable = true;
  programs.sway.enable = true;
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  # security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "23.11";
}
