{
  pkgs,
  lib,
  ...
}: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof gtklock || ${lib.getExe pkgs.gtklock} -d";
        unlock_cmd = ''pkill -xu "$USER" -SIGUSR1 gtklock'';
        before_sleep_cmd = "loginctl lock-session";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };

      listener = [
        {
          timeout = 45;
          on-timeout = ''bash -c 'if pidof gtklock >/dev/null; then swaymsg "output * power off"; else ${lib.getExe pkgs.chayang} -d 45 && swaymsg "output * power off"; fi' '';
          on-resume = ''swaymsg "output * power on"'';
        }
        {
          timeout = 120;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 300;
          on-timeout = ''bash -c 'if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ]; then systemctl suspend; fi' '';
        }
      ];
    };
  };
}
