{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "bottom";
        height = 30;
        spacing = 0;
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
        modules-center = [
          "sway/workspaces"
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
        "sway/workspaces" = {
          persistent-workspaces = {
            "1" = [
              "eDP-1"
            ];
            "2" = [
              "eDP-1"
            ];
            "3" = [
              "eDP-1"
            ];
            "4" = [
              "eDP-1"
            ];
            "5" = [
              "eDP-1"
            ];
            "6" = [
              "eDP-1"
            ];
            "7" = [
              "eDP-1"
            ];
            "8" = [
              "eDP-1"
            ];
            "9" = [
              "eDP-1"
            ];
            "10" = [
              "eDP-1"
            ];
            "11" = [
              "HEADLESS-1"
            ];
            "12" = [
              "HEADLESS-1"
            ];
            "13" = [
              "HEADLESS-1"
            ];
            "14" = [
              "HEADLESS-1"
            ];
            "15" = [
              "HEADLESS-1"
            ];
            "16" = [
              "HEADLESS-1"
            ];
            "17" = [
              "HEADLESS-1"
            ];
            "18" = [
              "HEADLESS-1"
            ];
            "19" = [
              "HEADLESS-1"
            ];
            "20" = [
              "HEADLESS-1"
            ];
          };
        };
        "custom/launcher" = {
          format = " 󰊠 ";
          tooltip = false;
          on-click = "fuzzel";
        };
        "custom/keyboard" = {
          format = "  󰌌  ";
          tooltip = false;
          on-click = "bash ~/.local/bin/toggle_wvkbd.sh";
        };
        "custom/close" = {
          format = " 󰅙 ";
          tooltip = false;
          on-click = "swaymsg kill";
        };
        "network#net2" = {
          tooltip = false;
          format = " {ifname}";
          format-wifi = " wifi:";
          format-ethernet = " {ifname}:";
          format-disconnected = " net:";
          max-length = 50;
        };
        network = {
          tooltip = false;
          format = "{ifname}";
          format-wifi = "{ipaddr}";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "disconnected";
          max-length = 50;
        };
        "custom/label_bt" = {
          tooltip = false;
          format = " bt:";
        };
        bluetooth = {
          format = "on";
          format-disabled = "off";
          format-connected = "on({num_connections})";
          tooltip = false;
        };
        idle_inhibitor = {
          format = "{icon}";
          tooltip = false;
          format-icons = {
            activated = " awake";
            deactivated = " idle";
          };
        };
        "custom/label_language" = {
          tooltip = false;
          format = "lang:";
        };
        "sway/language" = {
          format = "{short}";
          tooltip = false;
        };
        "custom/label_pulseaudio" = {
          tooltip = false;
          format = " vol:";
        };
        pulseaudio = {
          tooltip = false;
          format = "{volume}%";
          format-muted = "muted";
        };
        "battery#bat2" = {
          tooltip = false;
          states = {
            warning = 30;
            critical = 15;
          };
          format = " bat:";
          format-charging = " ac:";
        };
        battery = {
          tooltip = false;
          format = "{capacity}%";
          format-charging = "{capacity}%";
        };
        "custom/label_backlight" = {
          tooltip = false;
          format = " light:";
        };
        "custom/label_backlight2" = {
          tooltip = false;
          format = " light2:";
        };
        backlight = {
          tooltip = false;
          format = "{percent}%";
        };
        # "custom/brightness" = {
        #   format = "{percentage}%";
        #   tooltip = false;
        #   format-icons = [
        #     "󰃞"
        #     "󰃟"
        #     "󰃠"
        #   ];
        #   return-type = "json";
        #   exec-on-event = false;
        #   exec = "ddccontrol -r 0x10 dev:/dev/i2c-0 | grep Control | sed -En 's/.*\/([0-9]+)\/.*/\1/p' | { read x; echo '{"percentage":'${x}'}'; }";
        #   on-scroll-up = "ddccontrol -r 0x10 -W +10 dev:/dev/i2c-0";
        #   on-scroll-down = "ddccontrol -r 0x10 -W -10 dev:/dev/i2c-0";
        #   on-click = "ddccontrol -r 0x10 -w 0 dev:/dev/i2c-0";
        #   on-click-right = "ddccontrol -r 0x10 -w 100 dev:/dev/i2c-0";
        #   interval = 1;
        # };
        # "custom/brightness2" = {
        #   format = "{percentage}%";
        #   tooltip = false;
        #   format-icons = [
        #     "󰃞"
        #     "󰃟"
        #     "󰃠"
        #   ];
        #   return-type = "json";
        #   exec-on-event = false;
        #   exec = "ddccontrol -r 0x10 dev:/dev/i2c-2 | grep Control | sed -En 's/.*\/([0-9]+)\/.*/\1/p' | { read x; echo '{"percentage":'${x}'}'; }";
        #   on-scroll-up = "ddccontrol -r 0x10 -W +10 dev:/dev/i2c-2";
        #   on-scroll-down = "ddccontrol -r 0x10 -W -10 dev:/dev/i2c-2";
        #   on-click = "ddccontrol -r 0x10 -w 0 dev:/dev/i2c-2";
        #   on-click-right = "ddccontrol -r 0x10 -w 100 dev:/dev/i2c-2";
        #   interval = 1;
        # };
      };
    };
  };
}
