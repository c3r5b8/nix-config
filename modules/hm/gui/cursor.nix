{pkgs, ...}: {
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
}
