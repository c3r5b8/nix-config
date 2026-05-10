{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    ../../system/docker
    ../../system/users/c3r5b8.nix
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      c3r5b8 = import ./home.nix;
    };
  };
  networking = {
    hostName = "sargas";
    nameservers = ["1.1.1.1" "8.8.8.8"];
  };
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
