{
  lib,
  config,
  ...
}: {
  sops.secrets.glanceSecretKey = {};
  sops.templates."glance.env" = {
    content = ''
      GLANCE_SECRET_KEY=${config.sops.placeholder.glanceSecretKey}
    '';
  };

  environment.etc."homelab/glance" = {
    source = ./configs;
  };

  virtualisation.oci-containers.containers."glance" = {
    image = "docker.io/glanceapp/glance:latest";
    environmentFiles = [config.sops.templates."glance.env".path];
    volumes = [
      "/etc/homelab/glance/config:/app/config:ro"
      "/etc/homelab/glance/assets:/app/assets:ro"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.glance.rule" = "Host(`glance.c3r5b8.dev`)";
      "traefik.http.services.glance.loadbalancer.server.port" = "8080";

      "glance.name" = "glance";
      "glance.icon" = "si:glance";
      "glance.url" = "https://glance.c3r5b8.dev";
      "glance.same-tab" = "true";
      "glance.description" = "";
      "glance.hide" = "false";

      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=galnce"
      "--network=homelab_default"
    ];
  };
  systemd.services."podman-glance" = {
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
