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
    # anytype
    solaar

    # audio
    amberol

    # images
    loupe

    # videos
    celluloid
  ];
}
