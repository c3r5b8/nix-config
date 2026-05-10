{pkgs, ...}: {
  imports = [
    ../../home/c3r5b8
    ../../home/c3r5b8/desktop.nix
  ];
  home.packages = with pkgs; [
    nvtopPackages.intel
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
  programs.waybar.settings.mainBar = {
    "battery#bat2" = {
      bat = "BAT0";
    };
    "battery" = {
      bat = "BAT0";
    };
  };
}
