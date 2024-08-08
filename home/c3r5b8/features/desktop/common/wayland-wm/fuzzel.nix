{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Lexend:size=12";
        icon-theme = "Papirus-Dark";
        terminal = "kitty";
        lines = 16;
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        match = "a6e3a1ff";
        selection = "313244ff";
        selection-text = "cdd6f4ff";
        selection-match = "a6e3a1ff";
        border = "a6e3a1ff";
      };
      border = {
        width = 3;
        radius = 12;
      };
    };
  };
}
