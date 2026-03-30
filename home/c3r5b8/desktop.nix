{pkgs, ...}: {
  imports = [
    ./firefox
    ./foot
    ./sway
    ./theme
    ./waybar
    ./xdg
  ];
  home.packages = with pkgs; [
    telegram-desktop
  ];
}
