{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 13;
    };
    settings = {
      cursor_shape = "beam";
      confirm_os_window_close = "0";
    };
    theme = "Catppuccin-Mocha";
    shellIntegration = {
      enableFishIntegration = true;
      mode = "enabled";
    };
  };
}
