{
  imports = [
    ./fonts
    ./greetd
    ./pipewire
    ./thunar
    ./gtklock
  ];
  # HACK
  services.flatpak.enable = true;
}
