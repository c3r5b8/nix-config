{
  pkgs,
  lib,
  ...
}: {
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

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    hyprcursor.enable = true;
    name = "Bibata-Original-Ice";
    size = 22;
    sway.enable = true;
    x11.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  home.packages = [
    pkgs.qt6Packages.qtstyleplugin-kvantum
    pkgs.qt6Packages.qt6ct
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct
  ];

  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        custom_palette = false;
        icon_theme = "Papirus-Light";
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum";
      };
      Fonts = {
        fixed = ''"Fira Sans,14,-1,5,50,0,0,0,0,0"'';
        general = ''"Fira Sans,14,-1,5,50,0,0,0,0,0"'';
      };
    };

    "qt6ct/qt6ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        custom_palette = false;
        icon_theme = "Papirus-Light";
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum";
      };
      Fonts = {
        fixed = ''"Fira Sans,14,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
        general = ''"Fira Sans,14,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
      };
    };
  };

  xdg.configFile = {
    "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/refs/heads/main/themes/catppuccin-latte-green/catppuccin-latte-green.kvconfig";
      sha256 = "15rw2agx3y94glvml5raqj6yx3ddlkqdd3y1dnrpg7azxcxkc298";
    };
    "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/refs/heads/main/themes/catppuccin-latte-green/catppuccin-latte-green.svg";
      sha256 = "0cwsj6b6yv2iz5194fibqvqzcxzqdl2cvkm73p43d93pf87h8rdi";
    };
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin

    '';
    #   [Applications]
    #   catppuccin=qt5ct, org.qbittorrent.qBittorrent, hyprland-share-picker
    # '';
  };
}
