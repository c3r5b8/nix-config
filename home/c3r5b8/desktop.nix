{pkgs, ...}: {
  imports = [
    ./dunst
    ./firefox
    ./foot
    ./fuzzel
    ./hypridle
    ./sway
    ./theme
    ./waybar
    ./xdg
  ];
  home.packages = with pkgs; [
    telegram-desktop
  ];
}
