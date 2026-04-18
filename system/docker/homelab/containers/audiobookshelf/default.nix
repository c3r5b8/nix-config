{lib, ...}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/audiobookshelf/config 0700 1000 1000 -"
    "d /var/lib/homelab/audiobookshelf/metadata 0700 1000 1000 -"
  ];
  virtualisation.oci-containers.containers."audiobookshelf" = {
    image = "ghcr.io/advplyr/audiobookshelf:latest";
    environment = {
      "PGID" = "1000";
      "PUID" = "1000";
      "TZ" = "Europe/Kyiv";
    };
    volumes = [
      "/var/lib/homelab/audiobookshelf/config:/config:rw"
      "/var/lib/homelab/audiobookshelf/metadata:/metadata:rw"
      "/mnt/media:/media:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.audiobookshelf.rule" = "Host(`audiobooks.c3r5b8.dev`)";
      "traefik.http.services.audiobookshelf.loadbalancer.server.port" = "80";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=audiobookshelf"
      "--network=homelab_default"
      "--cap-add=NET_BIND_SERVICE"
    ];
  };
  systemd.services."podman-audiobookshelf" = {
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
