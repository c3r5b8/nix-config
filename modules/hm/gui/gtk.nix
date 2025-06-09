{pkgs, ...}: {
  gtk = {
    enable = true;

    font = {
      package = pkgs.fira;
      name = "Fira Sans";
      size = 14;
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "latte";
        accent = "green";
      };
      name = "Papirus-Light";
    };

    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = ["green"];
        variant = "latte";
      };
      name = "catppuccin-latte-green-standard";
    };
  };
}
