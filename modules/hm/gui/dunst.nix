{pkgs, ...}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };
    settings = {
      global = {
        follow = "mouse";
        width = "(400,500)";
        height = 300;
        origin = "top_right";
        offset = "10x50";
        font = "Fira Sans 13";
        progress_bar_corner_radius = 100;

        frame_color = "#40a02b";
        separator_color = "frame";
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
        frame_color = "#e64553";
      };
    };
  };
}
