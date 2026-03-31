{theme, ...}: {
  services.dunst = let
    light = {
      global = {
        frame_color = "#40a02b";
        separator_color = "frame";
        highlight = "#40a02b";
      };
      urgency_low = {
        background = "#eff1f5";
        foreground = "#4c4f69";
      };
      urgency_normal = {
        background = "#eff1f5";
        foreground = "#4c4f69";
      };
      urgency_critical = {
        background = "#eff1f5";
        foreground = "#4c4f69";
        frame_color = "#fe640b";
      };
    };
    dark = {
      global = {
        frame_color = "#a6e3a1";
        separator_color = "frame";
        highlight = "#a6e3a1";
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#fab387";
      };
    };
  in {
    enable = true;
    settings =
      if theme == "dark"
      then dark
      else light;
  };
}
