{pkgs, ...}: {
  home.packages = [pkgs.dunst];
  xdg.configFile."dunst/light".source = ./dunstrc_light;
  xdg.configFile."dunst/dark".source = ./dunstrc_dark;
}
