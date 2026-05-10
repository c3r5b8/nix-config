{
  lib,
  config,
  ...
}: {
  xdg.configFile."waybar/light".source = ./light.css;
  xdg.configFile."waybar/dark".source = ./dark.css;
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "bottom";
        height = 30;
        spacing = 0;
        modules-left = lib.mkDefault [
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
        modules-right = lib.mkDefault [
          "custom/label_language"
          "sway/language"
          "custom/label_pulseaudio"
          "pulseaudio"
          "battery#bat2"
          "battery"
          "custom/label_backlight"
          "backlight"
        ];
        "sway/workspaces" = {
          persistent-workspaces = let
            mkPersistentWorkspaces = outputToBase:
              lib.listToAttrs (
                lib.concatLists (
                  lib.mapAttrsToList (
                    output: base:
                      lib.genList (
                        i: let
                          wsNum = toString (base + i + 1);
                        in
                          lib.nameValuePair wsNum [output]
                      )
                      10
                  )
                  outputToBase
                )
              );
          in
            mkPersistentWorkspaces config.custom.sway.outputToBase;
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
      };
    };
    style = ''
      @import "theme.css";
      * {
        all: unset;
        min-height: 0;
        font-size: 20px;
      }

      window#waybar {
        background-color: @base;
      }

      #language,
      #pulseaudio,
      #battery,
      #backlight,
      #custom-launcher,
      #custom-label_bt,
      #custom-label_language,
      #custom-label_pulseaudio,
      #custom-label_backlight,
      #custom-label_backlight2,
      #custom-brightness,
      #custom-brightness2,
      #custom-keyboard,
      #custom-close,
      #clock,
      #power-profiles-daemon,
      #network,
      #bluetooth,
      #idle_inhibitor,
      #workspaces {
        font-family: "FiraCode Nerd Font";
        font-weight: 900;
        color: @text;
      }

      #pulseaudio.muted {
        color: @peach;
      }

      #custom-label_pulseaudio {
        color: @sky;
      }
      #custom-label_bt {
        color: @blue;
      }
      #network.net2 {
        color: @sapphire;
      }
      #network.net2.disconnected {
        color: @red;
      }
      #custom-label_backlight,
      #custom-label_backlight2 {
        color: @yellow;
      }
      #custom-label_language {
        color: @mauve;
      }
      #custom-launcher {
        color: @green;
      }
      #custom-keyboard {
        color: @blue;
      }
      #idle_inhibitor.activated {
        color: @red;
      }
      #battery.bat2.warning {
        color: @peach;
      }
      #battery.bat2.critical {
        color: @red;
      }
      #battery.bat2 {
        color: @blue;
      }

      #custom-close {
        color: @red;
      }
      #workspaces button {
        padding: 0px 12px 0px 12px;
        color: @text;
      }

      #workspaces button:hover {
        background: none;
        border: none;
        color: @teal;
        border-color: transparent;
        transition: none;
      }

      #workspaces button.empty {
        color: @overlay0;
      }

      #workspaces button.empty:hover {
        color: @teal;
      }

      #workspaces button.focused {
        border-radius: 0;
        color: @green;
        font-weight: bold;
      }
    '';
  };
}
