{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "theme";
      update_ms = 1000;
      proc_sorting = "cpu direct";
      proc_per_core = true;
    };
  };
  xdg.configFile."btop/themes/light.theme".source = ./light.theme;
  xdg.configFile."btop/themes/dark.theme".source = ./dark.theme;
}
