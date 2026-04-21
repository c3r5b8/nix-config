{lib, ...}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/vaultwarden 0700 1000 1000 -"
  ];

  virtualisation.oci-containers.containers."vaultwarden" = {
    image = "vaultwarden/server:latest";
    environment = {
      "DOMAIN" = "https://pass.c3r5b8.dev";
      "WEBSOCKET_ENABLED" = "true";
      "ROCKET_PORT" = "8080";
    };
    volumes = [
      "/var/lib/homelab/vaultwarden:/data:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.vaultwarden.rule" = "Host(`pass.c3r5b8.dev`)";
      "traefik.http.services.vaultwarden.loadbalancer.server.port" = "8080";
      "traefik.http.routers.vaultwarden.middlewares" = "localOnly@file";
    };
    user = "1000:1000";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=vaultwarden"
      "--network=homelab_default"
    ];
  };
  systemd.services."podman-vaultwarden" = {
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
