{pkgs, ...}: {
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.gnome-remote-desktop.enable = true;
  systemd.services.gnome-remote-desktop = {
    wantedBy = ["graphical.target"];
  };
  networking.firewall.allowedTCPPorts = [3389];

  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp
    orca
    geary
    gnome-user-docs
    gnome-maps
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
    panel-corners
    unblank
    gsconnect
    alphabetical-app-grid
    rounded-window-corners-reborn
  ];
}
