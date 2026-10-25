{pkgs, ...}: {
  imports = [
    ./cliphist
    ./dunst
    ./firefox
    ./foot
    ./fuzzel
    ./hypridle
    ./nm-menu
    ./sway
    ./swappy
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
    winbox
    moonlight-qt
    heroic
    signal-desktop
    remmina
    fladder
  ];
}
