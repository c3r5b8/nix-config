{pkgs, ...}: {
  imports = [
    ./vscode.nix
    ./gtk.nix
    ./firefox.nix
  ];

  home.packages = with pkgs; [
    arduino
    arduino-ide
  ];
}
