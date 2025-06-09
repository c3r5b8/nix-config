{
  config,
  pkgs,
  ...
}: {
  programs.hyprlock = let
    wallpaper = pkgs.fetchurl {
      url = "https://red.ngn.tf/img/g9d3o4yldxwe1.jpeg";
      hash = "sha256-GO+JEkH7HpD8Tos/NbvlzFnVdi73Bqt+Cko5LiSZysE=";
    };
  in {
    enable = true;

    settings = {
      general = {
        no_fade_in = true;
        grace = 3;
        disable_loading_bar = false;
        hide_cursor = true;
        ignore_empty_input = true;
        text_trim = true;
      };

      auth = {
        fingerprint = {
          enabled = true;
        };
      };

      background = [
        {
          monitor = "";
          # path = "${config.home.homeDirectory}/Downloads/wall.png";
          # path = "screenshot";
          path = "${wallpaper}";
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.7172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%H\")\"";
          color = "rgba(255, 255, 255, 1)";
          shadow_pass = 2;
          shadow_size = 3;
          shadow_color = "rgb(0,0,0)";
          shadow_boost = 1.2;
          font_size = 150;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -250";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%M\")\"";
          color = "rgba(255, 255, 255, 1)";
          font_size = 150;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -420";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%d %b %A\")\"";
          color = "rgba(255, 255, 255, 1)";
          font_size = 14;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -130";
          halign = "center";
          valign = "top";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "450, 60";
          outline_thickness = 0;
          outer_color = "rgba(0, 0, 0, 1)";
          dots_size = 0.1;
          dots_spacing = 1.0;
          dots_center = true;
          inner_color = "rgba(0, 0, 0, 1)";
          font_color = "rgba(200, 200, 200, 1)";
          fade_on_empty = false;
          font_family = "JetBrains Mono Nerd Font Mono";
          placeholder_text = ''<span foreground="##cdd6f4">$USER</span>'';
          hide_input = false;
          position = "0, -470";
          halign = "center";
          valign = "center";
          zindex = 10;
        }
      ];
    };
  };
}
