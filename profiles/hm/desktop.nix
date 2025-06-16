{pkgs, ...}: {
  imports = [
    ../../modules/hm/cli/ssh.nix
    ../../modules/hm/gui/dunst.nix
    ../../modules/hm/gui/theming.nix
    ../../modules/hm/gui/hypridle.nix
    ../../modules/hm/gui/hyprlock.nix
    ../../modules/hm/gui/foot.nix
    ../../modules/hm/gui/sway.nix
    ../../modules/hm/gui/tofi.nix
    ../../modules/hm/gui/waybar.nix
  ];

  home.packages = [
    pkgs.transmission_4-gtk
    pkgs.obsidian
    pkgs.element-desktop
  ];
}
