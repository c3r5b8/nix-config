{
  pkgs,
  inputs,
  ...
}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    #!/usr/bin/env bash
    notify-send "Starting rebuild"
    sudo nix-store --verify
    pushd /home/c3r5b8/dev/nix-config/ && sudo nixos-rebuild switch --flake .# --upgrade && notify-send "Done"
    popd
  '';
in {
  imports = [
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./bottom.nix
    ./yazi.nix
    ./xdg.nix
  ];

  home.packages =
    [
      rebuild
      pkgs.bc
      pkgs.dunst
      pkgs.libnotify
      pkgs.btop
      pkgs.ncdu
      pkgs.eza
      pkgs.ripgrep
      pkgs.fd
      pkgs.httpie
      pkgs.diffsitter
      pkgs.tmux
      pkgs.jq
      pkgs.nixd
      pkgs.nixfmt
    ]
    ++ [
      inputs.superfile.packages.${pkgs.system}.default
    ];
}
