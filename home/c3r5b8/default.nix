{pkgs, ...}: {
  imports = [
    ./bat
    ./btop
    ./fish
    ./git
    ./nvim
    ./ssh
    ./starship
    ./yazi
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  home.username = "c3r5b8";
  home.homeDirectory = "/home/c3r5b8";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    unrar
    gzip
    bzip2
    xz

    iperf3
    nmap
    xxd
  ];
}
