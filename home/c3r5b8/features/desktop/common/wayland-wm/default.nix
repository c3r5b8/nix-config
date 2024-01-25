{pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./waybar.nix
    ./dunst.nix
    ./fuzzel.nix
  ];
  home.packages = with pkgs; [
    gnome.gnome-keyring
    libsecret
    anytype
  ];
}
