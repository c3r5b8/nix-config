{
  inputs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    # ../../system/locale
    # ../../system/boot
    #     ../../system/theming
    ../../system/users
    # ../../system/impermanence
    # ../../system/network
    # ../../system/security
    #     ../../system/sway
  ];
  #   theme.variant = "light";
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      theme = config.theme;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      c3r5b8 = import ./home.nix;
    };
  };
  networking.hostName = "acrab";
  hardware.graphics = {
    enable = true;
    #extraPackages = with pkgs; [
    #  intel-media-driver
    #];
  };
  hardware = {
    #bluetooth = {
    #  enable = true;
    #  powerOnBoot = true;
    #};
  };
  #services = {
  #  blueman.enable = true;
  #};
  #environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable

  nixpkgs.config.allowUnfree = true;

  # programs.sway.enable = true;
  programs.firefox.enable = true;
  programs.neovim.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}
