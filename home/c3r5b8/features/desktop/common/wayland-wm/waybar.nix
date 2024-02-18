{pkgs, ...}: {
  home.packages = let
    wireguard = pkgs.writeShellScriptBin "wireguard" ''
      #!/run/current-system/sw/bin/bash
      service_status=$(systemctl status wg-quick-wg0.service | awk '/Active:/ {print $2}')
      if [[ $1 == "status" ]]; then
        if [[ $service_status == "active" ]]; then
          echo "󰌾"
        else
          echo "󰿆"
        fi
      fi

      if [[ $1 == "toggle" ]]; then
        case $service_status in
        active)
          sudo systemctl stop wg-quick-wg0.service
          ;;
        inactive)
          sudo systemctl start wg-quick-wg0.service
          ;;
        esac
        exit 0
      fi
    '';
  in [wireguard];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        exclusive = true;
        modules-left = [
          "sway/workspaces"
        ];
        modules-right = [
          "custom/wireguard"
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
        ];
        "sway/workspaces" = {
          "all-outputs" = true;
          "format" = "";
          "persistent_workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };
        "clock" = {
          format = "{:%H:%M}";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          tooltip-format = "{timeTo}, {capacity}% {power}";
          format-charging = "󰂄";
          format-plugged = "󰚥";
          format-icons = [
            "󰂃"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };
        "backlight" = {
          format = "{icon}";
          tooltip = false;
          format-icons = [
            "󰋙"
            "󰫃"
            "󰫄"
            "󰫅"
            "󰫆"
            "󰫇"
            "󰫈"
          ];
          on-scroll-up = "brightness s 1%+ -q";
          on-scroll-down = "brightness s 1%- -q";
        };
        "network" = {
          format-wifi = "󰖩";
          format-ethernet = "󰈀";
          tooltip-format = "󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}\n{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          format-disconnected = "󰖪";
        };
        "pulseaudio" = {
          tooltip = true;
          format = "{icon}";
          tooltip-format = "{desc}, {volume}%";
          format-muted = "󰖁";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "volume -t";
          on-scroll-up = "volume -i 1";
          on-scroll-down = "volume -d 1";
        };
        "custom/wireguard" = {
          format = "{}";
          on-click = "wireguard toggle";
          exec = "wireguard status";
          tooltip = false;
          interval = 2;
          class = "wireguard";
        };
      };
    };

    style = let
      snowflake = builtins.fetchurl rec {
        name = "Logo-${sha256}.svg";
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
        sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
      };
      green = "#a6e3a1";
    in ''
      window#waybar {
        background-color: #1e1e2e;
        color: #cdd6f4;
        font-family: FiraCode Nerd Font;
      }

      #workspaces {
        margin: 10px;
        margin-top: 4px;
        padding: 7px;
        padding-left: 4px;
        border-radius: 50px;
        background-color: #313244;
        font-size: 12px;
      }

      #workspaces button {
        color: #cdd6f4;
        padding: 2px 7px;
      }

      #workspaces button:hover {
        background: #313244;
        border: #313244;
        margin: 0;
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #workspaces button.focused {
        color: ${green};
      }

      #workspaces button.persistent {
        color: #9399b2;
      }

      #clock {
        color: #141b1e;
        font-weight: 900;
        background-color: ${green};
        font-size: 1.2em;
        border-radius: 10px;
        padding: 10 0px;
        margin: 0 10px;
        margin-bottom: 5px;
        margin-top: 8px;
      }

      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #custom-wireguard
      {
        font-size: 25px;
        margin-right: 15px;
      }
    '';
  };
}
