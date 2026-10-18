{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../home/c3r5b8
    ../../home/c3r5b8/desktop.nix
  ];
  home.packages = with pkgs; [
    nvtopPackages.amd
    eden
    nsz
  ];
  custom.sway.startup = [
    {command = "${lib.getExe' pkgs.sway "swaymsg"} create_output";}
  ];
  custom.sway.outputToBase = {
    "DP-2" = 0;
    "HEADLESS-1" = 10;
  };

  wayland.windowManager.sway.config.output = {
    "DP-2" = {
      resolution = "3440x1440@120Hz";
      pos = "0 0";
    };
    "HEADLESS-1" = {
      resolution = "1920x1200@60Hz";
      pos = "760 1440";
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
      "custom/label_backlight"
      "custom/brightness"
    ];
    "custom/brightness" = let
      ddcutil = "${pkgs.ddcutil}/bin/ddcutil";

      brightnessCommand = pkgs.writeShellScript "ddcutil-rate-limited" ''
        lock_file="''${XDG_RUNTIME_DIR:-/tmp}/ddcutil-brightness.lock"

        exec 9>"$lock_file"

        ${pkgs.util-linux}/bin/flock --nonblock 9 || exit 0

        ${pkgs.ddcutil}/bin/ddcutil "$@"
        result=$?
        ${pkgs.coreutils}/bin/sleep 0.2

        exit "$result"
      '';
    in {
      format = "{percentage}%";
      interval = "once";
      return-type = "json";
      exec = ''
        ${ddcutil} getvcp 10 | ${pkgs.sd}/bin/sd '^.*current value =\s+(\d+).*' '$1' | {
          read -r x
          printf '{"percentage":%s}\n' "$x"
        }
      '';
      on-scroll-up = "${brightnessCommand} setvcp 10 + 5";
      on-scroll-down = "${brightnessCommand} setvcp 10 - 5";
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
