{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/c3r5b8

    ../common/optional/docker.nix
    ../common/optional/jellyfin.nix
    ../common/optional/traefik.nix
    ../common/optional/vaultwarden.nix
    ../common/optional/ntfy.nix
    ../common/optional/qbittorrent.nix
    ../common/optional/factorio.nix
    ../common/optional/home-assistant.nix
    ../common/optional/memos.nix
    ../common/optional/homepage.nix
    ../common/optional/rss.nix
    ../common/optional/wordpress.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };
  security.sudo.wheelNeedsPassword = false;
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
  networking.networkmanager.enable = true;
  networking = {
    hostName = "sargas";
  };
  system.stateVersion = "24.05";
}
