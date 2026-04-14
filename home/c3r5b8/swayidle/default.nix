{
  pkgs,
  lib,
  ...
}: {
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${lib.getExe' pkgs.procps "pidof"} gtklock || ${lib.getExe pkgs.gtklock} -d";
      lock = "${lib.getExe' pkgs.procps "pidof"} gtklock || ${lib.getExe pkgs.gtklock} -d";
    };
    timeouts = [
      {
        timeout = 45;
        command = ''bash -c 'if ${lib.getExe' pkgs.procps "pidof"} gtklock >/dev/null; then ${lib.getExe' pkgs.sway "swaymsg"} "output * power off"; else ${lib.getExe pkgs.chayang} -d 45 && ${lib.getExe' pkgs.sway "swaymsg"} "output * power off"; fi' '';
        resumeCommand = ''${lib.getExe' pkgs.sway "swaymsg"} "output * power on"'';
      }
      {
        timeout = 120;
        command = "${lib.getExe' pkgs.procps "pidof"} gtklock || ${lib.getExe pkgs.gtklock} -d";
      }
      {
        timeout = 300;
        command = ''bash -c 'if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ]; then ${lib.getExe' pkgs.systemd "systemctl"} suspend; fi' '';
      }
    ];
  };
}
