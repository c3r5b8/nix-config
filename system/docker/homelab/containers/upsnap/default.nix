{
  lib,
  config,
  ...
}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/upsnap 0755 root root"
  ];

  virtualisation.oci-containers.containers."upsnap" = {
    image = "ghcr.io/seriousm4x/upsnap:latest";
    environment = {
      TZ = "Europe/Kyiv";
    };
    volumes = [
      "/var/lib/upsnap:/app/pb_data"
    ];
    labels = {
      "io.containers.autoupdate" = "registry";

      "traefik.enable" = "true";
      "traefik.http.routers.upsnap.rule" = "Host(`upsnap.c3r5b8.dev`)";
      "traefik.http.services.upsnap.loadbalancer.server.url" = "http://192.168.1.2:8090";
      "traefik.http.routers.upsnap.middlewares" = "localOnly@file";

      "glance.name" = "upsnap";
      "glance.icon" = "mdi:power";
      "glance.url" = "https://upsnap.c3r5b8.dev";
      "glance.same-tab" = "true";
      "glance.description" = "";
      "glance.hide" = "false";
    };
    log-driver = "journald";
    extraOptions = [
      "--network=host"
      "--cap-add=NET_RAW"
    ];
  };

  systemd.services."podman-upsnap" = {
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
