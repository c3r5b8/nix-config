{
  pkgs,
  inputs,
  ...
}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    #!/usr/bin/env bash
    notify-send "Starting rebuild"
    sudo nix-store --verify
    pushd /home/c3r5b8/nix-config/ && sudo nixos-rebuild switch --flake .# --upgrade && notify-send "Done"
    popd
  '';
in {
  imports = [
    ./git.nix
    ./ssh.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    rebuild
    bc
    dunst
    libnotify
    btop
    ncdu
    eza
    ripgrep
    fd
    httpie
    diffsitter
    tmux
    jq
    nixd
    nixfmt
  ];
}
