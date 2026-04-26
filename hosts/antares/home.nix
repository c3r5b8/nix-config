{pkgs, ...}: {
  imports = [
    ../../home/c3r5b8
    ../../home/c3r5b8/desktop.nix
  ];
  home.packages = with pkgs; [
    nvtopPackages.amd
  ];
  custom.sway.outputToBase = {
    "eDP-1" = 0;
    "HEADLESS-1" = 10;
  };

  wayland.windowManager.sway.config.output = {
    "eDP-1" = {
      resolution = "3072x1920@120Hz";
      pos = "0 0";
      scale = "1.5";
    };

  };
#   programs.waybar.settings.mainBar = {
#     modules-left = [
#       "clock"
#       "idle_inhibitor"
#       "custom/label_bt"
#       "bluetooth"
#       "network#net2"
#       "network"
#     ];
#     modules-right = [
#       "custom/label_language"
#       "sway/language"
#       "custom/label_pulseaudio"
#       "pulseaudio"
#     ];
#   };
}
