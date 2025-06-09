{pkgs, ...}: {
  programs.btop = {
    enable = true;
    settings.color_theme = "catppuccin_latte";
  };

  xdg.configFile = {
    "btop/themes/catppuccin_latte.theme".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/btop/f437574b600f1c6d932627050b15ff5153b58fa3/themes/catppuccin_latte.theme";
      hash = "sha256-kOlj6tXuCDoTWdy2lNl4TBv+QewuDUhtOwTw2b25Fzs=";
    };
  };
}
