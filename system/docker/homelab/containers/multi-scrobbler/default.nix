{
  lib,
  config,
  ...
}: {
  sops.secrets.lzToken = {};
  sops.secrets.lzUser = {};
  sops.secrets.lastFmApiKey = {};
  sops.secrets.lastFmApiSecret = {};

  sops.templates."multi-scrobbler.env" = {
    content = ''
      SOURCE_LASTFM_API_KEY=${config.sops.placeholder.lastFmApiKey}
      SOURCE_LASTFM_SECRET=${config.sops.placeholder.lastFmApiSecret}
      LZ_TOKEN=${config.sops.placeholder.lzToken}
      LZ_USER=${config.sops.placeholder.lzUser}
    '';
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/multi-scrobbler 0700 1000 1000 -"
  ];
  virtualisation.oci-containers.containers."multi-scrobbler" = {
    image = "docker.io/foxxmd/multi-scrobbler";
    environmentFiles = [config.sops.templates."multi-scrobbler.env".path];
    environment = {
      "BASE_URL" = "https://multiscrobbler.c3r5b8.dev:443";
      "PGID" = "1000";
      "PUID" = "1000";
      "TZ" = "Europe/Kyiv";
    };
    volumes = [
      "/var/lib/homelab//multi-scrobbler:/config:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.multi-scrobbler.rule" = "Host(`multiscrobbler.c3r5b8.dev`)";
      "traefik.http.services.multi-scrobbler.loadbalancer.server.port" = "9078";
      "traefik.http.routers.multi-scrobbler.middlewares" = "localOnly@file";

      "glance.name" = "multi-scrobbler";
      "glance.icon" = "si:lastdotfm";
      "glance.url" = "https://multiscrobbler.c3r5b8.dev";
      "glance.same-tab" = "true";
      "glance.description" = "";
      "glance.hide" = "false";

      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=multi-scrobbler"
      "--network=homelab_default"
    ];
  };
  systemd.services."podman-multi-scrobbler" = {
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
