{
  pkgs,
  lib,
  config,
  ...
}: let
  ddc-wrapper = pkgs.writeShellScriptBin "ddc-wrapper" ''
    set -euo pipefail

    BUS="$1"
    ACTION="$2"
    STEP=''${3:-5}

    if [[ -z "$BUS" || -z "$ACTION" ]]; then
      echo "Usage: ddc-wrapper <bus> <init|get|up|down> [step]" >&2
      exit 1
    fi

    STATE_DIR="''${XDG_STATE_HOME:-$HOME/.local/state}"
    mkdir -p "$STATE_DIR"
    STATE_FILE="$STATE_DIR/ddc_brightness_$BUS"
    LOCK_FILE="$STATE_DIR/ddc_brightness_$BUS.lock"
    PID_FILE="/tmp/ddc_applier_$BUS.pid"

    # Simple flock-based lock for state updates
    exec 9>"$LOCK_FILE"
    flock -n 9 || exit 0

    case "$ACTION" in
      init)
        if [[ -f "$STATE_FILE" ]]; then
          VAL=$(<"$STATE_FILE")
        else
          VAL=$(${pkgs.ddcutil}/bin/ddcutil --bus "$BUS" getvcp 10 -t 2>/dev/null \
            | ${pkgs.gawk}/bin/awk 'NF{print $4; exit}' || echo 50)
          echo "$VAL" > "$STATE_FILE"
        fi
        ${pkgs.ddcutil}/bin/ddcutil --bus "$BUS" --noverify --sleep-multiplier 0.5 setvcp 10 "$VAL" || true
        exit 0
        ;;
      get)
        cat "$STATE_FILE" 2>/dev/null || echo 50
        exit 0
        ;;
    esac

    # up / down
    VAL=$(cat "$STATE_FILE" 2>/dev/null || echo 50)
    case "$ACTION" in
      up)   VAL=$(( VAL + STEP )); (( VAL > 100 )) && VAL=100 ;;
      down) VAL=$(( VAL - STEP )); (( VAL < 0   )) && VAL=0   ;;
      *) exit 1 ;;
    esac
    echo "$VAL" > "$STATE_FILE"
    flock -u 9

    # Instant feedback
    ${pkgs.libnotify}/bin/notify-send -e \
      -h "string:x-canonical-private-synchronous:brightness-$BUS" \
      -h "int:value:$VAL" \
      -t 800 "Brightness (Bus $BUS): $VAL%"


    # Debounced apply
    if [[ -f "$PID_FILE" ]]; then
      kill -TERM "$(cat "$PID_FILE")" 2>/dev/null || true
      rm -f "$PID_FILE"
    fi

    (
      sleep 0.35
      ${pkgs.ddcutil}/bin/ddcutil --bus "$BUS" --noverify --sleep-multiplier 0.5 setvcp 10 "$VAL" || true
      rm -f "$PID_FILE"
    ) &
    echo $! > "$PID_FILE"
    disown
  '';
in {
  imports = [
    ../../home/c3r5b8
    ../../home/c3r5b8/desktop.nix
  ];
  home.packages = with pkgs; [
    nvtopPackages.amd
    eden
    nsz
    ddc-wrapper
  ];
  custom.sway.startup = [
    {command = "${lib.getExe' pkgs.sway "swaymsg"} create_output";}
  ];
  custom.sway.outputToBase = {
    "DP-2" = 0;
    "HDMI-A-1" = 10;
    "HEADLESS-1" = 20;
  };

  wayland.windowManager.sway.config.output = {
    "DP-2" = {
      resolution = "3440x1440@240Hz";
      pos = "1080 240";
    };
    "HDMI-A-1" = {
      resolution = "1920x1080@75Hz";
      pos = "0 0";
      transform = "270";
    };

    "HEADLESS-1" = {
      resolution = "1920x1200@60Hz";
      pos = "1840 1680";
    };
  };
  programs.waybar.settings.secondaryBar = {
    output = "!DP-2";
    position = "bottom";
    height = 30;
    spacing = 0;
    modules-left = [
      "clock"
    ];
    modules-center = [
      "sway/workspaces"
    ];
    "sway/workspaces" = config.programs.waybar.settings.mainBar."sway/workspaces";
    "clock" = config.programs.waybar.settings.mainBar."clock";
  };
  programs.waybar.settings.mainBar = {
    output = "DP-2";
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
      "custom/label_backlight"
      "custom/brightness"
      "custom/label_backlight2"
      "custom/brightness2"
    ];
    "custom/brightness" = {
      format = "{}%";
      interval = "once";
      signal = 8;
      exec = "ddc-wrapper 11 get";
      on-scroll-up = "ddc-wrapper 11 up";
      on-scroll-down = "ddc-wrapper 11 down";
      tooltip = false;
      exec-on-event = true;
    };
    "custom/brightness2" = {
      format = "{}%";
      interval = "once";
      signal = 8;
      exec = "ddc-wrapper 7 get";
      on-scroll-up = "ddc-wrapper 7 up";
      on-scroll-down = "ddc-wrapper 7 down";
      tooltip = false;
      exec-on-event = true;
    };
  };
  xdg.desktopEntries.eden = let
    eden-portable = pkgs.writeShellScriptBin "eden-portable" ''
      mkdir -p /games/Switch/eden/user
      cd /games/Switch/eden
      exec ${pkgs.eden}/bin/eden "$@"
    '';
  in {
    name = "Eden (portable)";
    comment = "Nintendo Switch Emulator (portable)";
    exec = "${eden-portable}/bin/eden-portable %u";
    categories = ["Game" "Emulator"];
    terminal = false;
    startupNotify = true;
    icon = "eden";
  };
}
