{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    ../../system/desktop.nix
    ../../system/users/c3r5b8.nix

    ../../system/steam
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
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
  };
  services.logind.settings.Login.HandlePowerKey = "suspend";

  hardware.i2c.enable = true;

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
