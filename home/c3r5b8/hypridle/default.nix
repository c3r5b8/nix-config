{
  pkgs,
  lib,
  ...
}: let
  gtklockCmd = "${lib.getExe pkgs.gtklock} -d";
  swaymsg = lib.getExe' pkgs.sway "swaymsg";
  pidof = lib.getExe' pkgs.procps "pidof";

  dpmsTimeoutScript = pkgs.writeShellScriptBin "hypridle-dpms-timeout" ''
    if ${pidof} gtklock >/dev/null 2>&1; then
      ${swaymsg} "output * power off"
    else
      ${lib.getExe pkgs.chayang} -d 45 && ${swaymsg} "output * power off"
    fi
  '';

  batterySuspendScript = pkgs.writeShellScriptBin "battery-suspend" ''
    if ! ${lib.getExe' pkgs.systemd "systemd-ac-power"}; then
      ${lib.getExe' pkgs.systemd "systemctl"} suspend
    fi
  '';
in {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "${pidof} gtklock || ${gtklockCmd}";
        before_sleep_cmd = "${pidof} gtklock || ${gtklockCmd}";
        after_sleep_cmd = "${swaymsg} \"output * power on\"";

        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;
      };

      listener = [
        {
          timeout = 45;
          on-timeout = lib.getExe dpmsTimeoutScript;
          on-resume = "${swaymsg} \"output * power on\"";
        }

        {
          timeout = 120;
          on-timeout = "${pidof} gtklock || ${gtklockCmd}";
        }

        {
          timeout = 300;
          on-timeout = lib.getExe batterySuspendScript;
        }
      ];
    };
  };
}
