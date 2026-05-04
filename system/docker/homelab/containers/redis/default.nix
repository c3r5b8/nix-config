{lib, ...}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/redis 0700 1000 1000 -"
  ];
  virtualisation.oci-containers.containers."redis" = {
    image = "redis:8-alpine";
    volumes = [
      "/var/lib/homelab/redis:/data:rw"
    ];
    labels = {
      "glance.hide" = "true";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=redis"
      "--network=homelab_default"
    ];
  };
  systemd.services."podman-redis" = {
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
