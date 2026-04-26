{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../../home/c3r5b8
    ../../home/c3r5b8/desktop.nix

    inputs.iio-sway.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    nvtopPackages.intel
  ];
  custom.sway.startup = let
    lisgd = pkgs.lisgd.override {
      conf = ./lisgd_conf.h;
    };
  in [
    {command = "${lib.getExe lisgd}";}
    {command = "${inputs.iio-sway.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/iio-sway";}
  ];
  programs.waybar.settings.mainBar = let
    toggle_wvkbd = let
      wvkbd = pkgs.wvkbd.overrideAttrs (finalAttrs: prevAttrs: {
        patches = (prevAttrs.patches or []) ++ [./wvkbd.patch];
        makeFlags = (prevAttrs.makeFlags or []) ++ ["LAYOUT=deskintl"];
      });
    in
      pkgs.writeShellApplication {
        name = "toggle_wbkbd";
        text = ''
          #!/bin/bash

          if ! pgrep "wvkbd" >/dev/null; then
            ${wvkbd}/bin/wvkbd-deskintl  --landscape-layers full,cyrillic -l full,cyrillic --hidden &
          fi

          pkill -34 "wvkbd"
        '';
      };
  in {
    modules-left = [
      "custom/launcher"
      "custom/keyboard"
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
      "battery#bat2"
      "battery"
      "custom/label_backlight"
      "backlight"
      "custom/close"
    ];
    "custom/launcher" = {
      format = " 󰊠 ";
      tooltip = false;
      on-click = "${lib.getExe pkgs.fuzzel}";
    };
    "custom/keyboard" = {
      format = "  󰌌  ";
      tooltip = false;
      on-click = "${lib.getExe toggle_wvkbd}";
    };
    "custom/close" = {
      format = " 󰅙 ";
      tooltip = false;
      on-click = "swaymsg kill";
    };
  };
}
