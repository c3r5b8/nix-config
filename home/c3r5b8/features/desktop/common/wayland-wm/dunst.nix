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
        font = "Iosevka 13";
        progress_bar_corner_radius = 100;

        frame_color = "#a6e3a1";
        separator_color = "frame";
      };
      urgency_low = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };
      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };
      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#eba0ac";
      };
    };
  };
}
