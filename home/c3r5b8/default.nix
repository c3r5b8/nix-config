{pkgs, ...}: {
  imports = [
    ./firefox
    ./fish
    ./git
    ./nvim
    ./plasma
    ./ssh
    ./starship
    ./theme
    ./yazi
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  home.username = "c3r5b8";
  home.homeDirectory = "/home/c3r5b8";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  home.packages = [pkgs.telegram-desktop pkgs.home-manager];
  xdg = {
    enable = true;
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
      config = {
        common = {
          default = [
            "kde"
          ];
        };
      };
    };
  };
}
