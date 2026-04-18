{
  lib,
  config,
  ...
}: {
  sops.secrets.cloudflareApiKey = {};
  sops.templates."traefik.env" = {
    content = ''
      CF_DNS_API_TOKEN=${config.sops.placeholder.cloudflareApiKey}
    '';
  };

  environment.etc."homelab/traefik" = {
    source = ./configs;
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/traefik/acme 0700 1000 1000 -"
  ];
  virtualisation.oci-containers.containers."traefik" = {
    image = "traefik:latest";
    environmentFiles = [config.sops.templates."traefik.env".path];
    volumes = [
      "/etc/homelab/traefik/dynamic_conf:/etc/traefik/dynamic_conf:ro"
      "/etc/homelab/traefik/traefik.yaml:/etc/traefik/traefik.yaml:ro"
      "/var/lib/homelab/traefik/acme:/etc/traefik/acme:rw,U"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    ports = [
      "80:80/tcp"
      "443:443/tcp"
      "443:443/udp"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.traefik.rule" = "Host(`proxy.c3r5b8.dev`)";
      "traefik.http.services.traefik.loadbalancer.server.port" = "8080";
    };
    log-driver = "journald";
    extraOptions = [
      "--group-add=991"
      "--network-alias=traefik"
      "--network=homelab_default"
      "--cap-add=NET_BIND_SERVICE"
    ];
  };
  systemd.services."podman-traefik" = {
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
