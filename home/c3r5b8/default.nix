{pkgs, ...}: {
  imports = [
    ./firefox
    ./fish
    ./git
    ./nvim
    ./plasma
    ./theme
    ./yazi
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  home.username = "c3r5b8";
  home.homeDirectory = "/home/c3r5b8";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  home.packages = [pkgs.home-manager];
}
