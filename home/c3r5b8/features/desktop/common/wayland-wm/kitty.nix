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
    # settings = {
    #   main = {
    #     term = "xterm-256color";
    #     font = "FiraCode Nerd Font:size=13";

    #     dpi-aware = "no";
    #   };
    #   cursor = {
    #     style = "beam";
    #     blink = "yes";
    #   };
    #   colors = {
    #     foreground = "cdd6f4";
    #     background = "1e1e2e";
    #     regular0 = "45475a";
    #     regular1 = "f38ba8";
    #     regular2 = "a6e3a1";
    #     regular3 = "f9e2af";
    #     regular4 = "89b4fa";
    #     regular5 = "f5c2e7";
    #     regular6 = "94e2d5";
    #     regular7 = "bac2de";
    #     bright0 = "585b70";
    #     bright1 = "f38ba8";
    #     bright2 = "a6e3a1";
    #     bright3 = "f9e2af";
    #     bright4 = "89b4fa";
    #     bright5 = "f5c2e7";
    #     bright6 = "94e2d5";
    #     bright7 = "a6adc8";
    #   };
    # };
  };
}
