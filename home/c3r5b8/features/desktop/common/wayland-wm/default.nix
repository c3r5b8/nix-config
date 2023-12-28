{pkgs, ...}: {
  imports = [
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    gnome.gnome-keyring
    libsecret
    anytype
  ];
}
