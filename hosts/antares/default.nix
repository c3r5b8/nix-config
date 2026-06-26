{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    ../../system/desktop.nix
    ../../system/users/c3r5b8.nix

    ../../system/bluetooth
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
    hostName = "antares";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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
