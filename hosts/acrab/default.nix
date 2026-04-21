{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    ../../system/desktop.nix
    ../../system/users/c3r5b8.nix

#     ../../system/bluetooth
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
#       theme = config.custom.theme;
    };
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users = {
      c3r5b8 = import ./home.nix;
    };
  };
  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];
  networking = {
    hostName = "acrab";
#     networkmanager.wifi.powersave = false;
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 5d --keep 5";
    flake = "/home/c3r5b8/dev/nix-config/";
  };
  services.logind.settings.Login.HandlePowerKey = "suspend";
  programs.sway.enable = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
