{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        spacing = 0;
        modules-left = [
          "sway/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "idle_inhibitor"
          "network"
          "backlight"
          "sway/language"
          "pulseaudio"
          "bluetooth"
          "power-profiles-daemon"
          "battery"
        ];
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = false;
          format-icons = {
            performance = "perf";
            balanced = "bal";
            power-saver = "pwr";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          tooltip = false;
          format-icons = {
            activated = "no_idle";
            deactivated = "idle";
          };
        };
        "sway/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
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
              "HDMI-A-1"
            ];
            "12" = [
              "HDMI-A-1"
            ];
            "13" = [
              "HDMI-A-1"
            ];
            "14" = [
              "HDMI-A-1"
            ];
            "15" = [
              "HDMI-A-1"
            ];
            "16" = [
              "HDMI-A-1"
            ];
            "17" = [
              "HDMI-A-1"
            ];
            "18" = [
              "HDMI-A-1"
            ];
            "19" = [
              "HDMI-A-1"
            ];
            "20" = [
              "HDMI-A-1"
            ];
          };
        };
        cpu = {
          format = "{usage}%";
          tooltip = false;
          interval = 1;
        };
        backlight = {
          format = "{percent}%";
          tooltip = false;
        };
        bluetooth = {
          format = "disconn";
          format-disabled = "off";
          format-connected = "conn ({num_connections})";
        };
        pulseaudio = {
          format = "{volume}%";
          format-muted = "mut";
          format-bluetooth = "bt: {volume}%";
          format-bluetooth-muted = "mut(bt)";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          tooltip = false;
          max-volume = 100;
        };
        network = {
          format = "{ifname}";
          format-wifi = "{essid}";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "disconnected";
          tooltip = false;
          max-length = 50;
        };
        battery = {
          interval = 5;
          states = {
            good = 80;
            warning = 20;
            critical = 10;
          };
          format = "{capacity}%";
          format-critical = "{capacity}%!!";
          format-warning = "{capacity}%";
          format-full = "{capacity}%";
          format-charging = "+{capacity}%";
          format-charging-warning = "+{capacity}%";
          format-charging-critical = "+{capacity}%";
          format-plugged = "{capacity}%";
          format-alt = "{time}";
          tooltip = false;
        };
        clock = {
          format = "{:%a %d %b %H:%M}";
          tooltip = false;
          interval = 5;
        };
      };
    };

    style = ''
            @define-color rosewater #dc8a78;
            @define-color flamingo #dd7878;
            @define-color pink #ea76cb;
            @define-color mauve #8839ef;
            @define-color red #d20f39;
            @define-color maroon #e64553;
            @define-color peach #fe640b;
            @define-color yellow #df8e1d;
            @define-color green #40a02b;
            @define-color teal #179299;
            @define-color sky #04a5e5;
            @define-color sapphire #209fb5;
            @define-color blue #1e66f5;
            @define-color lavender #7287fd;
            @define-color text #4c4f69;
            @define-color subtext1 #5c5f77;
            @define-color subtext0 #6c6f85;
            @define-color overlay2 #7c7f93;
            @define-color overlay1 #8c8fa1;
            @define-color overlay0 #9ca0b0;
            @define-color surface2 #acb0be;
            @define-color surface1 #bcc0cc;
            @define-color surface0 #ccd0da;
            @define-color base #eff1f5;
            @define-color mantle #e6e9ef;
            @define-color crust #dce0e8;

      * {
        padding: 0;
        margin: 0;
        min-height: 0;
        border-radius: 0;
        border: none;
        text-shadow: none;
        transition: none;
        box-shadow: none;
      }

      window#waybar {
        color: @text;
        background: @base;
      }

      window#waybar.hidden {
        opacity: 1;
      }

      #workspaces button,
      #workspaces button:hover,
      #workspaces button.visible,
      #workspaces button.visible:hover,
      #workspaces button.active,
      #workspaces button.active:hover,
      #workspaces button.urgent,
      #window,
      #cpu,
      #backlight,
      #custom-memory,
      #language,
      #pulseaudio,
      #pulseaudio.muted,
      #bluetooth,
      #idle_inhibitor,
      #idle_inhibitor.activated,
      #idle_inhibitor.deactivated,
      #network,
      #network.disabled,
      #network.disconnected,
      #network.linked,
      #network.ethernet,
      #network.wifi,
      #power-profiles-daemon,
      #power-profiles-daemon.performance,
      #power-profiles-daemon.balanced,
      #power-profiles-daemon.power-saver,
      #battery,
      #battery.critical,
      #battery.warning,
      #clock {
        font-family: JetBrainsMono Nerd Font Propo;
        font-size: 14px;
        font-weight: 800;
        color: @text;
        background: @base;
      }

      #window,
      #tray,
      #disk,
      #cpu,
      #temperature,
      #temperature.critical,
      #backlight,
      #custom-memory,
      #pulseaudio,
      #pulseaudio.muted,
      #battery,
      #battery.critical,
      #battery.warning,
      #idle_inhibitor,
      #idle_inhibitor.activated,
      #idle_inhibitor.deactivated,
      #network,
      #network.disabled,
      #network.disconnected,
      #network.linked,
      #network.ethernet,
      #network.wifi,
      #language,
      #bluetooth,
      #power-profiles-daemon,
      #power-profiles-daemon.performance,
      #power-profiles-daemon.balanced,
      #power-profiles-daemon.power-saver,
      #clock {
        padding-right: 8px;
      }
      /* left */
      #workspaces {
        margin: 0px;
      }

      #workspaces button {
        color: @text;
        padding: 0 4px;
        min-width: 25px;
      }

      #workspaces button:hover {
        color: @teal;
      }

      #workspaces button.empty {
        color: @overlay0;
      }

      #workspaces button.empty:hover {
        color: @teal;
      }

      #workspaces button.visible {
        color: @green;
      }

      #workspaces button.visible:hover {
        color: @teal;
      }

      #workspaces button.urgent {
        color: @red;
      }

      /* center */
      #clock {
        color: @green;
      }

      /* center */
      #idle_inhibitor.activated {
        color: @red;
      }
      #idle_inhibitor.deactivated {
        color: @subtext0;
      }

      #language {
        color: @flamingo;
      }

      #cpu {
        color: @blue;
      }


      #network.disabled,
      #network.disconnected {
        color: @red;
      }
      #network.ethernet {
        color: @sky;
      }

      #network.wifi {
        color: @teal;
      }


      #backlight {
        color: @yellow;
      }

      #bluetooth {
        color: @blue;
      }

      #custom-memory {
        color: @sapphire;
      }


      #pulseaudio {
        color: @lavender;
      }
      #pulseaudio.muted {
        color: @peach
      }


      #power-profiles-daemon.performance {
        color: @red;
      }
      #power-profiles-daemon.balanced {
        color: @mauve;
      }
      #power-profiles-daemon.power-saver {
        color: @green;
      }


      #battery {
        color: @green;
      }

      #battery.critical {
        color: @red;
      }

      #battery.warning {
        color: @peach;
      }'';
  };
}
