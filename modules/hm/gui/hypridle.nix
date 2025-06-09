{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        unlock_cmd = "pkill -USR1 hyprlock";
        before_sleep_cmd = "hyprlock";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };

      listener = [
        {
          timeout = 120;
          on-timeout = "swaymsg \"output * dpms off\"";
          on-resume = "swaymsg \"output * dpms on\"";
        }
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
