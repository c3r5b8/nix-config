{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = let
    swayWorkspace = pkgs.writeShellScriptBin "swayWorkspace" ''
      #!/bin/sh
      if [ -z "$1" ]; then
        echo "Usage: $0 <workspace-number> [move]"
        exit 1
      fi

      current_output=$(swaymsg -t get_outputs -r | ${pkgs.jq}/bin/jq -r '.[] | select(.focused) | .name')

      if [ "$current_output" = "eDP-1" ]; then
        workspace_number="$1"
      elif [ "$current_output" = "HDMI-A-1" ]; then
        workspace_number=$((10 + $1))
      elif [[ "$current_output" =~ ^HEADLESS ]]; then
        workspace_number=$((20 + $1))
      else
        echo "Unknown output: $current_output"
        exit 1
      fi

      if [ "$2" = "move" ]; then
        swaymsg move container to workspace number $workspace_number
      else
        swaymsg workspace number $workspace_number
      fi
    '';
  in [pkgs.nemo pkgs.wl-clipboard swayWorkspace];

  wayland.windowManager.sway = let
    wallpaper = pkgs.fetchurl {
      url = "https://red.ngn.tf/img/g9d3o4yldxwe1.jpeg";
      hash = "sha256-GO+JEkH7HpD8Tos/NbvlzFnVdi73Bqt+Cko5LiSZysE=";
    };
  in {
    enable = true;
    package = pkgs.sway;
    checkConfig = true;

    config = {
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      defaultWorkspace = "workspace number 1";
      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "${pkgs.tofi}/bin/tofi/tofi-drun --drun-launch=true";

      startup = [
        {
          command = "${pkgs.autotiling}/bin/autotiling";
          always = true;
        }
        {
          command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          always = true;
        }
        {
          command = "${pkgs.hyprlock}/bin/hyprlock";
          always = false;
        }
        {
          command = "${pkgs.sway}/bin/swaymsg create_output";
          always = false;
        }
        {
          command = "${pkgs.hypridle}/bin/hypridle";
          always = true;
        }
      ];

      input = {
        "type:touchpad" = {
          accel_profile = "adaptive";
          drag = "enabled";
          dwt = "enabled";
          natural_scroll = "enabled";
          scroll_method = "two_finger";
          tap = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us,ua";
          xkb_options = "grp:alt_shift_toggle,caps:escape";
          xkb_capslock = "disabled";
        };
      };

      seat = {
        "*" = {
          hide_cursor = "30000";
        };
      };

      output = {
        "eDP-1" = {
          resolution = "3072x1920@120Hz";
          bg = "${wallpaper} fill";
          pos = "0 0";
          scale = "1.6";
          scale_filter = "linear";
          subpixel = "rgb";
        };
        "HEADLESS-1" = {
          bg = "${wallpaper} fill";
          resolution = "2560x1600@120Hz";
          # disable = "true";
          pos = "1920 1080";
          scale = "2";
          subpixel = "rgb";
        };
        "HDMI-A-1" = {
          bg = "${wallpaper} fill";
          pos = "1920 0";
          subpixel = "rgb";
        };
      };

      floating = {
        modifier = "Mod4";
      };
      bindkeysToCode = true;

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        left = config.wayland.windowManager.sway.config.left;
        down = config.wayland.windowManager.sway.config.down;
        up = config.wayland.windowManager.sway.config.up;
        right = config.wayland.windowManager.sway.config.right;
      in {
        "${modifier}+space" = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${pkgs.tofi}/bin/tofi-drun --drun-launch=true";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaymsg exit";
        "${modifier}+Escape" = "exec ${pkgs.hyprlock}/bin/hyprlock";
        "${modifier}+1" = "exec swayWorkspace 1";
        "${modifier}+2" = "exec swayWorkspace 2";
        "${modifier}+3" = "exec swayWorkspace 3";
        "${modifier}+4" = "exec swayWorkspace 4";
        "${modifier}+5" = "exec swayWorkspace 5";
        "${modifier}+6" = "exec swayWorkspace 6";
        "${modifier}+7" = "exec swayWorkspace 7";
        "${modifier}+8" = "exec swayWorkspace 8";
        "${modifier}+9" = "exec swayWorkspace 9";
        "${modifier}+0" = "exec swayWorkspace 10";

        "${modifier}+Shift+1" = "exec swayWorkspace 1 move";
        "${modifier}+Shift+2" = "exec swayWorkspace 2 move";
        "${modifier}+Shift+3" = "exec swayWorkspace 3 move";
        "${modifier}+Shift+4" = "exec swayWorkspace 4 move";
        "${modifier}+Shift+5" = "exec swayWorkspace 5 move";
        "${modifier}+Shift+6" = "exec swayWorkspace 6 move";
        "${modifier}+Shift+7" = "exec swayWorkspace 7 move";
        "${modifier}+Shift+8" = "exec swayWorkspace 8 move";
        "${modifier}+Shift+9" = "exec swayWorkspace 9 move";
        "${modifier}+Shift+0" = "exec swayWorkspace 10 move";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+Tab" = "workspace next";
        "${modifier}+Shift+Tab" = "workspace prev";
        "${modifier}+Shift+space" = "floating toggle";

        "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | wl-copy";
        "Ctrl+Print" = lib.mkForce ''exec ${pkgs.grim}/bin/grim -o \ $(swaymsg -t get_outputs | ${pkgs.jq}/bin/jq -r '.[] |           select(.focused) | .name') \ ~/pictures/screenshots/$(date +'%s_grim.png')'';
        "Shift+Print" = lib.mkForce ''exec ${pkgs.grim}/bin/grim -g \ "\"$(swaymsg -t get_tree | ${pkgs.jq}/bin/jq -j '.. | select(.type?) | select(.focused).rect \ "\\(.x),\\(.y) \\(.width)x\\(.height)"')" ~/pictures/screenshots/$(date +'%s_grim.png')'';

        "XF86AudioForward" = "exec ${pkgs.playerctl}/bin/playerctl position +10";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioRewind" = "exec ${pkgs.playerctl}/bin/playerctl position -10";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl stop";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute         @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume         @DEFAULT_AUDIO_SINK@ 1%+";
        "XF86AudioMicMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set         5-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5+";
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "eDP-1";
        }
        {
          workspace = "2";
          output = "eDP-1";
        }
        {
          workspace = "3";
          output = "eDP-1";
        }
        {
          workspace = "4";
          output = "eDP-1";
        }
        {
          workspace = "5";
          output = "eDP-1";
        }
        {
          workspace = "6";
          output = "eDP-1";
        }
        {
          workspace = "7";
          output = "eDP-1";
        }
        {
          workspace = "8";
          output = "eDP-1";
        }
        {
          workspace = "9";
          output = "eDP-1";
        }
        {
          workspace = "10";
          output = "eDP-1";
        }

        {
          workspace = "11";
          output = "HDMI-A-1";
        }
        {
          workspace = "12";
          output = "HDMI-A-1";
        }
        {
          workspace = "13";
          output = "HDMI-A-1";
        }
        {
          workspace = "14";
          output = "HDMI-A-1";
        }
        {
          workspace = "15";
          output = "HDMI-A-1";
        }
        {
          workspace = "16";
          output = "HDMI-A-1";
        }
        {
          workspace = "17";
          output = "HDMI-A-1";
        }
        {
          workspace = "18";
          output = "HDMI-A-1";
        }
        {
          workspace = "19";
          output = "HDMI-A-1";
        }
        {
          workspace = "20";
          output = "HDMI-A-1";
        }
      ];

      window.commands = [
        {
          criteria = {class = "firefox";};
          command = "mark Browser";
        }
        {
          criteria = {
            app_id = "firefox";
            title = "Firefox — Sharing Indicator";
          };
          command = "floating enable";
        }
      ];

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      colors = {
        focused = {
          border = "#7287fd";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#40a02b";
          childBorder = "#40a02b";
        };
        focusedInactive = {
          border = "#9ca0b0";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#9ca0b0";
          childBorder = "#9ca0b0";
        };
        unfocused = {
          border = "#9ca0b0";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#9ca0b0";
          childBorder = "#9ca0b0";
        };
        urgent = {
          border = "#fe640b";
          background = "#eff1f5";
          text = "#fe640b";
          indicator = "#9ca0b0";
          childBorder = "#fe640b";
        };
        placeholder = {
          border = "#9ca0b0";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#9ca0b0";
          childBorder = "#9ca0b0";
        };
        background = "#eff1f5";
      };
    };
    extraConfig = ''
      bindgesture swipe:3:left workspace next
      bindgesture swipe:3:right workspace prev
      bindgesture swipe:3:up workspace next
      bindgesture swipe:3:down workspace prev

      smart_borders on
      default_border pixel 4

      floating_modifier Mod4 normal
      output HEADLESS-1 disable
    '';
  };
}
