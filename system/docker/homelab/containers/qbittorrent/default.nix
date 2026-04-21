{lib, ...}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/qbittorrent 0700 1000 1000 -"
  ];
  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "lscr.io/linuxserver/qbittorrent:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/vuetorrent/vuetorrent-lsio-mod:latest";
      "PGID" = "1000";
      "PUID" = "1000";
      "TORRENTING_PORT" = "6881";
      "TZ" = "Europe/Kyiv";
      "WEBUI_PORT" = "8080";
    };
    volumes = [
      "/var/lib/homelab/qbittorrent:/config:rw"
      "/mnt/media:/downloads:rw"
    ];
    ports = [
      "6881:6881/udp"
      "6881:6881/tcp"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.qbittorent.rule" = "Host(`qb.c3r5b8.dev`)";
      "traefik.http.services.qbittorent.loadbalancer.server.port" = "8080";
      "traefik.http.routers.qbittorent.middlewares" = "localOnly@file";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=qbittorrent"
      "--network=homelab_default"
    ];
  };
  systemd.services."podman-qbittorrent" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-homelab_default.service"
    ];
    requires = [
      "podman-network-homelab_default.service"
    ];
    partOf = [
      "podman-compose-homelab-root.target"
    ];
    wantedBy = [
      "podman-compose-homelab-root.target"
    ];
  };
}
