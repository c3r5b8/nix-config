{lib, ...}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/jellyfin 0700 1000 1000 -"
  ];
  virtualisation.oci-containers.containers."jellyfin" = {
    image = "lscr.io/linuxserver/jellyfin:latest";
    environment = {
      "PGID" = "1000";
      "PUID" = "1000";
      "TZ" = "Europe/Kyiv";
    };
    volumes = [
      "/var/lib/homelab/jellyfin:/config:rw"
      "/mnt/media:/media:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.jellyfin.rule" = "Host(`jellyfin.c3r5b8.dev`)";
      "traefik.http.services.jellyfin.loadbalancer.server.port" = "8096";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=jellyfin"
      "--network=homelab_default"
    ];
  };
  systemd.services."podman-jellyfin" = {
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
