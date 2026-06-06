{
  imports = [
    ./fonts
    ./greetd
    ./pipewire
    ./sunshine
    ./thunar
    ./gtklock
    ./xdg
  ];
  # HACK
  services.flatpak.enable = true;
}
