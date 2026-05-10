{
  imports = [
    ./fonts
    ./greetd
    ./pipewire
    #     ./sunshine
    ./thunar
    ./gtklock
  ];
  # HACK
  services.flatpak.enable = true;
}
