{
  pkgs,
  theme,
  ...
}: let
  icon_theme =
    pkgs.catppuccin-papirus-folders.overrideAttrs
    (finalAttrs: prevAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "c3r5b8";
        repo = "papirus-folders";
        rev = "5d4e00367e93390e5375b88b6d33b501fff0efc4";
        sha256 = "sha256-EBqpud/z2On70ny1MFHknRHGqrnRwb+9t3I1dpUY5So=";
      };
    });
in {
  gtk = {
    enable = true;
    # cursorTheme = {
    #   name = "Bibata-Original-Ice";
    #   package = pkgs.bibata-cursors;
    #   size = 24;
    # };
    iconTheme = {
      name = "Papirus";
      package =
        icon_theme.override
        {
          accent = "green";
          flavor =
            if theme == "light"
            then "latte"
            else "mocha";
        };
    };
    theme = {
      name =
        if theme == "light"
        then "catppuccin-latte-green-standard"
        else "catppuccin-mocha-green-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = ["green"];
        variant =
          if theme == "light"
          then "latte"
          else "mocha";
      };
    };
  };
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    name = "Bibata-Original-Ice";
    size = 24;
    sway.enable = true;
  };
}
