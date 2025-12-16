{
  imports = [
    ./nvim
    ./gnome
    ./fish
    ./git
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  home.username = "c3r5b8";
  home.homeDirectory = "/home/c3r5b8";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
