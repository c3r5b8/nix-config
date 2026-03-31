{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  dark = {
    focused = {
      border = "#a6e3a1";
      background = "#1e1e2e";
      text = "#cdd6f4";
      indicator = "#a6e3a1";
      childBorder = "#a6e3a1";
    };

    focusedInactive = {
      border = "#6c7086";
      background = "#1e1e2e";
      text = "#cdd6f4";
      indicator = "#6c7086";
      childBorder = "#6c7086";
    };

    unfocused = {
      border = "#6c7086";
      background = "#1e1e2e";
      text = "#cdd6f4";
      indicator = "#6c7086";
      childBorder = "#6c7086";
    };

    urgent = {
      border = "#fab387";
      background = "#1e1e2e";
      text = "#fab387";
      indicator = "#6c7086";
      childBorder = "#fab387";
    };

    placeholder = {
      border = "#6c7086";
      background = "#1e1e2e";
      text = "#cdd6f4";
      indicator = "#6c7086";
      childBorder = "#6c7086";
    };

    background = "#1e1e2e";
  };
  light = {
    focused = {
      border = "#40a02b";
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
  workspaceSwitch = pkgs.writeShellApplication {
    name = "sway-workspace-switch";
    runtimeInputs = with pkgs; [sway jq];
    text = ''
      #!/usr/bin/env bash
      if [[ -z "$1" ]]; then
        echo "Usage: $0 <number> [move]" >&2
        exit 1
      fi

      current_output=$(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused) | .name')

      declare -A baseMap
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (out: base: "baseMap[${out}]=${toString base}") config.custom.sway.outputToBase)}

      base="''${baseMap[$current_output]:-}"
      if [[ -z "$base" ]]; then
        echo "Unknown output: $current_output" >&2
        echo "Add it to custom.sway.outputToBase in your Nix config" >&2
        exit 1
      fi

      workspace_number=$((base + $1))

      set +u
      if [[ "$2" == "move" ]]; then
        swaymsg move container to workspace number "$workspace_number"
      else
        swaymsg workspace number "$workspace_number"
      fi
      set -u
    '';
  };
  volumeHelper = pkgs.writeShellApplication {
    name = "volume-helper";
    text = ''
      #!/bin/sh
      if ! command -v pactl >/dev/null; then
          exit 0
      fi

      # pactl output depends on the current locale
      export LANG=C.UTF-8 LC_ALL=C.UTF-8

      DEFAULT_STEP=5
      LIMIT=''${LIMIT:-100}
      SINK="@DEFAULT_SINK@"

      clamp() {
          if [ "$1" -lt 0 ]; then
              echo "0"
          elif [ "$1" -gt "$LIMIT" ]; then
              echo "$LIMIT"
          else
              echo "$1"
          fi
      }

      get_sink_volume() {
          ret=$(pactl get-sink-volume "$1")
          ret=''${ret%%%*}
          ret=''${ret##* }
          echo "$ret"
      }

      CHANGE=0
      VOLUME=-1

      # Safer argument parsing (fixes "$1: unbound variable" under `set -u`)
      while [ $# -gt 0 ]; do
          case "$1" in
              --sink)
                  SINK=''${2:-$SINK}
                  shift 2 ;;
              -l|--limit)
                  LIMIT=''${2:-$LIMIT}
                  shift 2 ;;
              --set-volume)
                  VOLUME=''${2:-$VOLUME}
                  shift 2 ;;
              -i|--increase)
                  CHANGE=''${2:-$DEFAULT_STEP}
                  shift 2 ;;
              -d|--decrease)
                  CHANGE="-''${2:-$DEFAULT_STEP}"
                  shift 2 ;;
              *)
                  break ;;
          esac
      done

      if [ "$CHANGE" -ne 0 ]; then
          VOLUME=$(get_sink_volume "$SINK")
          VOLUME=$((VOLUME + CHANGE))
          pactl set-sink-volume "$SINK" "$(clamp "$VOLUME")%"
      elif [ "$VOLUME" -ge 0 ]; then
          pactl set-sink-volume "$SINK" "$(clamp "$VOLUME")%"
      fi

      # Display desktop notification
      if ! command -v ${lib.getExe pkgs.libnotify} >/dev/null; then
          exit 0
      fi

      VOLUME=$(get_sink_volume "$SINK")
      TEXT="Volume: ''${VOLUME}%"

      case $(pactl get-sink-mute "$SINK") in
          *yes*)
              TEXT="Volume: muted"
              VOLUME=0
              ;;
      esac

      ${lib.getExe pkgs.libnotify} \
          --app-name sway \
          --expire-time 800 \
          --hint string:x-canonical-private-synchronous:volume \
          --hint "int:value:$VOLUME" \
          --transient \
          "$TEXT"
    '';
  };
in {
  options.custom.sway.outputToBase = lib.mkOption {
    type = lib.types.attrsOf lib.types.int;
    default = {
      "eDP-1" = 0;
      "HDMI-A-1" = 10;
      "HEADLESS-1" = 20;
    };
  };
  options.custom.sway.startup = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule {
      options = {
        command = lib.mkOption {
          type = lib.types.str;
          description = "Command that will be executed on startup.";
        };

        always = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to run command on each sway restart.";
        };
      };
    });
    default = [];
  };
  config.wayland.windowManager.sway = {
    enable = true;
    config = {
      startup =
        [
          {command = "${lib.getExe pkgs.dunst}";}
          {command = "${lib.getExe pkgs.hypridle}";}
          {
            command =
              if theme == "dark"
              then "pkill -12 foot"
              else "pkill -10 foot";
            always = true;
          }
        ]
        ++ config.custom.sway.startup;
      input = {
        "type:touchpad" = {
          accel_profile = "adaptive";
          drag = "enabled";
          dwt = "enabled";
          drag_lock = "disabled";
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
          xcursor_theme = "Bibata-Original-Ice 24";
        };
      };

      floating.modifier = "Mod4";

      workspaceOutputAssign = lib.flatten (lib.mapAttrsToList (
          output: base:
            map (i: {
              workspace = toString (base + i);
              output = output;
            }) (lib.range 1 10)
        )
        config.custom.sway.outputToBase);

      keybindings =
        {
          "Mod4+space" = "exec ${lib.getExe' pkgs.foot "footclient"}";
          "Mod4+Shift+q" = "kill";
          "Mod4+d" = "exec ${lib.getExe pkgs.fuzzel}";
          "Mod4+Shift+c" = "reload";
          "Mod4+Shift+e" = "exec swaymsg exit";
          # "$mod+Shift+t" = "exec ~/.local/bin/switch_theme.sh toggle";
          # "$mod+Escape" = "exec gtklock -d";
          "Mod4+f" = "fullscreen";
          "Mod4+Shift+space" = "floating toggle";

          "Mod4+h" = "focus left";
          "Mod4+j" = "focus down";
          "Mod4+k" = "focus up";
          "Mod4+l" = "focus right";

          "Mod4+Shift+h" = "move left";
          "Mod4+Shift+j" = "move down";
          "Mod4+Shift+k" = "move up";
          "Mod4+Shift+l" = "move right";

          "XF86AudioPlay" = "exec ${lib.getExe pkgs.playerctl} play-pause";
          "XF86AudioStop" = "exec ${lib.getExe pkgs.playerctl} stop";

          "XF86AudioNext" = "exec ${lib.getExe pkgs.playerctl} next";
          "XF86AudioPause" = "exec ${lib.getExe pkgs.playerctl} pause";
          "XF86AudioPrev" = "exec ${lib.getExe pkgs.playerctl} previous";

          "Print" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} copy anything";
          "Ctrl+Print" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} savecopy anything";

          "XF86AudioRaiseVolume" = "exec ${lib.getExe volumeHelper} --increase 5";
          "XF86AudioLowerVolume" = "exec ${lib.getExe volumeHelper} --decrease 5";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle && ${lib.getExe volumeHelper}";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        }
        // (let
          keys = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "0"];
        in
          lib.listToAttrs (lib.concatLists (lib.imap0 (i: key: let
              n = i + 1;
            in [
              {
                name = "Mod4+${key}";
                value = "exec ${lib.getExe workspaceSwitch} ${toString n}";
              }
              {
                name = "Mod4+Shift+${key}";
                value = "exec ${lib.getExe workspaceSwitch} ${toString n} move";
              }
            ])
            keys)));

      bindkeysToCode = true;
      gaps.smartBorders = "on";
      window = {
        border = 4;
        titlebar = false;
      };
      output = {
        "*" = {
          bg =
            if theme == "light"
            then "${./light.jpg} fill"
            else "${./dark.png} fill";
        };
      };
      bars = [{command = "${lib.getExe pkgs.waybar}";}];
      colors =
        if theme == "light"
        then light
        else dark;
      defaultWorkspace = "workspace number 1";
      modes = {};
    };
    extraConfig = ''
      bindgesture swipe:3:left workspace next
      bindgesture swipe:3:right workspace prev
      bindgesture swipe:3:up workspace next
      bindgesture swipe:3:down workspace prev


      set $brightness_notification_cmd  VALUE=$(${lib.getExe pkgs.brightnessctl} i | grep -i current | awk '{print $4}' | sed 's/(//' | sed 's/)//') && \
              ${lib.getExe pkgs.libnotify} -e -h string:x-canonical-private-synchronous:brightness \
                  -h "int:value:$VALUE" -t 800 "Brightness: ''${VALUE}"

      bindsym --locked XF86MonBrightnessDown exec ${lib.getExe pkgs.brightnessctl} -q set 5%- -n && $brightness_notification_cmd
      bindsym --locked XF86MonBrightnessUp exec ${lib.getExe pkgs.brightnessctl} -q set +5% && $brightness_notification_cmd
    '';
  };
}
