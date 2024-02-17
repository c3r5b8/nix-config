{
  config,
  pkgs,
  lib,
  ...
}: let
  accent = "#a6e3a1";
in {
  imports = [
    ../common
    ../common/wayland-wm
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.packages = let
    volume = let
      pamixer = "${pkgs.pamixer}/bin/pamixer";
      notify-send = pkgs.libnotify + "/bin/notify-send";
    in
      pkgs.writeShellScriptBin "volume" ''
        #!/bin/sh

        ${pamixer} "$@"

        volume="$(${pamixer} --get-volume-human)"

        if [ "$volume" = "muted" ]; then
            ${notify-send} -r 69 \
                -a "Volume" \
                "Muted" \
                -i ${./mute.svg} \
                -t 888 \
                -u low
        else
            ${notify-send} -r 69 \
                -a "Volume" "Currently at $volume" \
                -h int:value:"$volume" \
                -i ${./volume.svg} \
                -t 888 \
                -u low
        fi
      '';
    brightness = let
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      light = "${pkgs.light}/bin/light";
      notify-send = pkgs.libnotify + "/bin/notify-send";
    in
      pkgs.writeShellScriptBin "brightness" ''
        #!/bin/sh
        ${brightnessctl} "$@"
        brightness="$(${light})"
        ${notify-send} -r 69 \
            -a "Brightness" "Currently at $brightness" \
            -h int:value:"$brightness" \
            -i ${./sun.svg} \
            -t 888 \
            -u low
      '';
  in [volume brightness pkgs.libnotify];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      bindkeysToCode = true;
      modifier = "Mod4";
      colors = {
        focused = {
          border = accent;
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = accent;
          childBorder = accent;
        };
        focusedInactive = {
          border = "#1e1e2e";
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = "#1e1e2e";
          childBorder = "#11111b";
        };
        unfocused = {
          border = "#585b70";
          background = "#585b70";
          text = "#b4befe";
          indicator = "#585b70";
          childBorder = "#11111b";
        };
        urgent = {
          border = "#f38ba8";
          background = "#f38ba8";
          text = "#11111b";
          indicator = "#111111";
          childBorder = "#111111";
        };
        placeholder = {
          border = "#111111";
          background = "#111111";
          text = "#111111";
          indicator = "#111111";
          childBorder = "#111111";
        };
      };
      floating = {
        border = 2;
        modifier = config.wayland.windowManager.sway.config.modifier;
        titlebar = false;
      };
      input = {
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "us,ua";
          xkb_options = "grp:alt_shift_toggle";
          xkb_capslock = "disabled";
        };
        "type:touchpad" = {
          accel_profile = "adaptive";
          drag = "enabled";
          dwt = "enabled";
          natural_scroll = "enabled";
          scroll_method = "two_finger";
          tap = "enabled";
        };
      };
      output = {
        "eDP-1" = {
          pos = "0,0";
          mode = "1920x1080@120Hz";
        };
        "HEADLESS-1" = {
          pos = "0,1080";
          mode = "2560x1600@120Hz";
          # scale = "1.6";
        };
      };
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      # terminal = "${pkgs.foot}/bin/footclient";
      gaps.smartBorders = "on";
      seat = {"*" = {hide_cursor = "30000";};};
      defaultWorkspace = "1";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in {
        "${modifier}+space" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+f" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+c" = "exec ${pkgs.vscode}/bin/code";
        # "${modifier}+e" = "exec nautilus";
        "${modifier}+d" = "exec ${pkgs.fuzzel}/bin/fuzzel";
        # "${modifier}+v" = "exec ${pkgs.cliphist}/bin/cliphist list | ${pkgs.tofi}/bin/tofi | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        "${modifier}+Return" = "focus mode_toggle";
        # "${modifier}+r" = "exec grim -g '$(slurp)' -t ppm - | tesseract - - -l ukr+eng | wl-copy";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+Shift+f" = "fullscreen";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+c" = "exec tmux new-session -d -s rebuilding 'rebuild'";
        "${modifier}+Shift+e" = "exec swaymsg exit";
        "${modifier}+Control+Shift+Left" = "move workspace to output left";
        "${modifier}+Control+Shift+Right" = "move workspace to output right";
        "${modifier}+Control+Shift+Up" = "move workspace to output up";
        "${modifier}+Control+Shift+Down" = "move workspace to output down";
        "XF86MonBrightnessDown" = "exec brightness s 5%-";
        "XF86MonBrightnessUp" = "exec brightness s 5%+";
        "XF86AudioRaiseVolume" = "exec volume -i 5";
        "XF86AudioLowerVolume" = "exec volume -d 5";
        "XF86AudioMute" = "exec volume -t";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        # "Print" = "exec ${pkgs.wayshot}/bin/wayshot -f Screenshots/$(date +%d.%m.%y_%T_screenshot.png).png";
        # "Ctrl+Print" = "exec ${pkgs.wayshot}/bin/wayshot --stdout | ${pkgs.wl-clipboard}/bin/wl-copy";
      };
      window.commands = [
        {
          command = "move scratchpad";
          criteria = {
            class = "rebuilding";
          };
        }
      ];
      bars = [{command = "${pkgs.waybar}/bin/waybar";}];
      startup = [
        {command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK";}
        {command = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";}
        # {command = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";}
        {command = "${pkgs.autotiling}/bin/autotiling";}
        # {command = "cd .startpage/dist && python -m http.server 9999";}
      ];
      window = {
        border = 2;
        titlebar = false;
      };
    };
    extraConfig = let
      mod = config.wayland.windowManager.sway.config.modifier;
    in ''
      bindsym --whole-window ${mod}+button4 workspace prev
      bindsym --whole-window ${mod}+button5 workspace next
      bindgesture swipe:3:left workspace next
      bindgesture swipe:3:right workspace prev
      bindgesture swipe:3:up workspace next
      bindgesture swipe:3:down workspace prev
    '';
  };
}
