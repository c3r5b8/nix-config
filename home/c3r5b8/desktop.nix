{pkgs, ...}: {
  imports = [
    ./dunst
    ./firefox
    ./foot
    ./fuzzel
    ./sway
    ./swayidle
    ./theme
    ./thunderbird
    ./waybar
    ./xdg
  ];
  home.packages = with pkgs; [
    telegram-desktop
    obsidian
    android-tools
    rocketchat-desktop
  ];
}
