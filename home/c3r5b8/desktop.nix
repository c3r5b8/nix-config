{pkgs, ...}: {
  imports = [
    ./firefox
    ./foot
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
