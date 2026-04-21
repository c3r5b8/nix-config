{
  imports = [
    ../../home/c3r5b8
    ../../home/c3r5b8/desktop.nix
  ];
  custom.sway.outputToBase = {
    "HDMI-A-1" = 0;
    "DP-1" = 10;
    "HEADLESS-1" = 20;
  };

  wayland.windowManager.sway.config.output = {
    "HDMI-A-1" = {
      resolution = "1920x1080@75Hz";
      pos = "0 0";
    };

    "DP-1" = {
      "resolution" = "1920x1080@60Hz";
      pos = "1920 0";
    };
  };
  programs.waybar.settings.mainBar = {
    modules-left = [
      "clock"
      "idle_inhibitor"
      "custom/label_bt"
      "bluetooth"
      "network#net2"
      "network"
    ];
    modules-right = [
      "custom/label_language"
      "sway/language"
      "custom/label_pulseaudio"
      "pulseaudio"
    ];
  };
}
