{pkgs, ...}: {
  imports = [
    ./firefox
    ./fish
    ./foot
    ./git
    ./nvim
    ./sway
    ./waybar
    ./yazi
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  home.username = "c3r5b8";
  home.homeDirectory = "/home/c3r5b8";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  home.packages = [pkgs.home-manager];
  specialisation = {
    light.configuration = {
      wayland.windowManager.sway.config.colors = {
        background = "#eff1f5";

        focused = {
          border = "#40a02b";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#40a02b";
          childBorder = "#40a02b";
        };

        focusedInactive = {
          border = "#9ca0b0";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#9ca0b0";
          childBorder = "#9ca0b0";
        };

        unfocused = {
          border = "#9ca0b0";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#9ca0b0";
          childBorder = "#9ca0b0";
        };

        urgent = {
          border = "#fe640b";
          background = "#eff1f5";
          text = "#fe640b";
          indicator = "#9ca0b0";
          childBorder = "#fe640b";
        };

        placeholder = {
          border = "#9ca0b0";
          background = "#eff1f5";
          text = "#4c4f69";
          indicator = "#9ca0b0";
          childBorder = "#9ca0b0";
        };
      };
    };
    dark.configuration = {
      wayland.windowManager.sway.config = {
        colors = {
          background = "#1e1e2e";

          focused = {
            border = "#a6e3a1";
            background = "#1e1e2e";
            text = "#cdd6f4";
            indicator = "#a6e3a1";
            childBorder = "#a6e3a1";
          };

          focusedInactive = {
            border = "#6c7086";
            background = "#1e1e2e";
            text = "#cdd6f4";
            indicator = "#6c7086";
            childBorder = "#6c7086";
          };

          unfocused = {
            border = "#6c7086";
            background = "#1e1e2e";
            text = "#cdd6f4";
            indicator = "#6c7086";
            childBorder = "#6c7086";
          };

          urgent = {
            border = "#fab387";
            background = "#1e1e2e";
            text = "#fab387";
            indicator = "#6c7086";
            childBorder = "#fab387";
          };

          placeholder = {
            border = "#6c7086";
            background = "#1e1e2e";
            text = "#cdd6f4";
            indicator = "#6c7086";
            childBorder = "#6c7086";
          };
        };
      };
    };
  };
}
