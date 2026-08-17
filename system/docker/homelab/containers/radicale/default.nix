{
  lib,
  config,
  ...
}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/radicale 0750 root root -"
  ];
  virtualisation.oci-containers.containers."radicale" = {
    image = "docker.io/tomsquest/docker-radicale:latest";
    volumes = [
      "/var/lib/homelab/radicale:/data"
    ];
    extraOptions = [
      "--init"
      "--read-only"
      "--security-opt=no-new-privileges:true"
      "--cap-drop=ALL"
      "--cap-add=SETUID"
      "--cap-add=SETGID"
      "--cap-add=CHOWN"
      "--cap-add=KILL"
      "--memory=256m"
      "--pids-limit=50"
      "--health-cmd=curl -f http://127.0.0.1:5232 || exit 1"
      "--health-interval=30s"
      "--health-retries=3"
      "--network-alias=radicale"
      "--network=homelab_default"
      "--user=0:0"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.radicale.rule" = "Host(`dav.c3r5b8.dev`)";
      "traefik.http.services.radicale.loadbalancer.server.port" = "5232";

      "glance.hide" = "true";

      "io.containers.autoupdate" = "registry";
    };
    log-driver = "journald";
  };
  systemd.services."podman-radicale" = {
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
