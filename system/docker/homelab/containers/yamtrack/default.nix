{
  lib,
  config,
  ...
}: {
  sops.secrets.yamtrackSecret = {};
  sops.secrets.tmdbApi = {};

  sops.templates."yamtrack.env" = {
    content = ''
      SECRET=${config.sops.placeholder.yamtrackSecret}
      TMDB_API=${config.sops.placeholder.tmdbApi}
      LASTFM_API_KEY=${config.sops.placeholder.lastFmApiKey}
    '';
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/yamtrack 0700 1000 1000 -"
  ];
  virtualisation.oci-containers.containers."yamtrack" = {
    image = "ghcr.io/dannyvfilms/yamtrack:latest";
    environmentFiles = [config.sops.templates."yamtrack.env".path];
    environment = {
      "ADMIN_ENABLED" = "True";
      "URLS" = "https://yamtrack.c3r5b8.dev";
      "REDIS_URL" = "redis://redis:6379";
    };
    volumes = [
      "/var/lib/homelab/yamtrack:/yamtrack/db:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.yamtrack.rule" = "Host(`yamtrack.c3r5b8.dev`)";
      "traefik.http.services.yamtrack.loadbalancer.server.port" = "8000";
      "traefik.http.routers.yamtrack.middlewares" = "localOnly@file";

      "glance.name" = "yamtrack";
      "glance.icon" = "si:trakt";
      "glance.url" = "https://yamtrack.c3r5b8.dev";
      "glance.same-tab" = "true";
      "glance.description" = "";
      "glance.hide" = "false";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=yamtrack"
      "--network=homelab_default"
    ];
  };
  systemd.services."podman-yamtrack" = {
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
