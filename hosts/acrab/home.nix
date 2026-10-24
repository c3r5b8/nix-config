{pkgs, ...}: {
  imports = [
    ../../home/c3r5b8
    ../../home/c3r5b8/desktop.nix
  ];
  home.packages = with pkgs; [
    nvtopPackages.amd
  ];
  custom.sway.outputToBase = {
    "DP-1" = 0;
    "HEADLESS-1" = 10;
  };

  wayland.windowManager.sway.config.output = {
    "DP-1" = {
      "resolution" = "1920x1080@60Hz";
      pos = "0 0";
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
