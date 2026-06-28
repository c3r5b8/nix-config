{pkgs, ...}: {
  imports = [
    ./dunst
    ./firefox
    ./foot
    ./fuzzel
    ./hypridle
    ./sway
    ./theme
    ./thunderbird
    ./waybar
    ./xdg
  ];
  home.packages = with pkgs; [
    telegram-desktop
    obsidian
    android-tools
    super-productivity

    cider-2
    inkscape
    qbittorrent
    krita
    sdrpp
    wireshark
    gimp3
    # jellyfin-desktop
    winbox
    moonlight-qt
    heroic
    signal-desktop
    remmina
  ];
}
