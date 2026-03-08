{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
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
    hostName = "shaula";
    networkmanager.wifi.powersave = false;
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  programs.sway.enable = true;
  # programs.firefox.enable = true;
  # programs.neovim.enable = true;
  environment.systemPackages = [pkgs.foot pkgs.yazi pkgs.thunar];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}
