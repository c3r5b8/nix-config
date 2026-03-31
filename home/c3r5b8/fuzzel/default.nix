{theme, ...}: {
  programs.fuzzel = let
    light = {
      background = "eff1f5ff";
      text = "4c4f69ff";
      prompt = "5c5f77ff";
      placeholder = "8c8fa1ff";
      input = "4c4f69ff";
      match = "40a02bff";
      selection = "acb0beff";
      selection-text = "4c4f69ff";
      selection-match = "40a02bff";
      counter = "8c8fa1ff";
      border = "40a02bff";
    };
    dark = {
      background = "1e1e2eff";
      text = "cdd6f4ff";
      prompt = "bac2deff";
      placeholder = "7f849cff";
      input = "cdd6f4ff";
      match = "a6e3a1ff";
      selection = "585b70ff";
      selection-text = "cdd6f4ff";
      selection-match = "a6e3a1ff";
      counter = "7f849cff";
      border = "a6e3a1ff";
    };
  in {
    enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font";
        use-bold = "yes";
        icon-theme = "Papirus";
        fields = "filename,name,generic,exec,categories,keywords,comment";
        terminal = "footclient -a '{cmd}' -T '{cmd}' {cmd}";
        vertical-pad = 40;
      };
      colors =
        if theme == "dark"
        then dark
        else light;
      border = {
        width = 4;
        radius = 0;
      };
    };
  };
}
