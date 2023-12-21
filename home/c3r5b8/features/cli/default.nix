{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    #!/usr/bin/env bash
    notify-send "Starting rebuild"
    sudo nix-store --verify
    pushd /home/c3r5b8/nix-config/ && sudo nixos-rebuild switch --flake .# --upgrade && notify-send "Done"
    popd
  '';
in {
  imports = [
    # ./bash.nix
    # ./bat.nix
    # ./direnv.nix
    # ./fish.nix
    # ./gh.nix
    ./git.nix
    # ./gpg.nix
    # ./jujutsu.nix
    # ./lyrics.nix
    # ./nix-index.nix
    # ./pfetch.nix
    # ./ranger.nix
    # ./screen.nix
    # ./shellcolor.nix
    ./ssh.nix
    # ./starship.nix
    # ./xpo.nix
  ];

  home.packages = with pkgs; [
    # comma # Install and run programs by sticking a , before them
    # distrobox # Nice escape hatch, integrates docker images with my environment

    rebuild # Rebuild my system
    bc # Calculator
    dunst # Notification daemon
    libnotify # Notification library
    btop # System viewer
    ncdu # TUI disk usage
    eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    diffsitter # Better diff
    tmux
    jq # JSON pretty printer and manipulator
    # trekscii # Cute startrek cli printer
    # timer # To help with my ADHD paralysis

    nixd # Nix LSP
    nixfmt # Nix formatter
    # nvd # Differ
    # nix-output-monitor
    # nh # Nice wrapper for NixOS and HM

    # ltex-ls # Spell checking LSP

    # tly # Tally counter
  ];
}
