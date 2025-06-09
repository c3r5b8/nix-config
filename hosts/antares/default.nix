{inputs, ...}: {
  imports = [
    ../../modules/nixos/system/_common.nix

    ./hardware-configuration.nix
    ./disko.nix

    ../../profiles/nixos/base.nix
    ../../profiles/nixos/desktop.nix
    ../../profiles/nixos/impermanence.nix

    ../../users/c3r5b8
    # ./modules/nixos/impermanence.nix
    # ./modules/nixos/tailscale.nix
    # ./modules/nixos/greetd.nix
    # ./modules/nixos/users.nix
    # ./modules/nixos/sops.nix
    # ./modules/nixos/sunshine.nix
    # ./modules/nixos/fonts.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.sway.enable = true;
  programs.firefox.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";

  # home-manager = {
  #   extraSpecialArgs = {inherit inputs;};
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   backupFileExtension = "backup";
  #   users = {
  #     "c3r5b8" = import ./home.nix;
  #   };
  # };
  services.fprintd.enable = true;
  networking.hostName = "antares";
}
