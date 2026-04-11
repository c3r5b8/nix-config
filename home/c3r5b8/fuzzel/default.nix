{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font";
        use-bold = "yes";
        icon-theme = "Papirus-Catppuccin-latte";
        fields = "filename,name,generic,exec,categories,keywords,comment";
        terminal = "footclient -a '{cmd}' -T '{cmd}' {cmd}";
        vertical-pad = 40;
        include = "~/.config/fuzzel/theme.ini";
      };
      border = {
        width = 4;
        radius = 0;
      };
    };
  };
  xdg.configFile."fuzzel/light".source = ./light.ini;
  xdg.configFile."fuzzel/dark".source = ./dark.ini;
}
