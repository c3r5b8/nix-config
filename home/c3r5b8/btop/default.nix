{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "theme";
    };
  };
  xdg.configFile."btop/themes/light.theme".source = ./light.theme;
  xdg.configFile."btop/themes/dark.theme".source = ./dark.theme;
}
