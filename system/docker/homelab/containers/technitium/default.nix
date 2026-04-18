{
  lib,
  config,
  ...
}: {
  networking.firewall.allowedTCPPorts = [53 5380];
  networking.firewall.allowedUDPPorts = [53];

  sops.secrets.technitiumAdminPass = {};
  sops.templates."technitium.env" = {
    content = ''
      DNS_SERVER_ADMIN_PASSWORD=${config.sops.placeholder.technitiumAdminPass}
    '';
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/homelab/technitium 0700 1000 1000 -"
  ];

  virtualisation.oci-containers.containers."technitium" = {
    image = "technitium/dns-server:latest";
    environmentFiles = [config.sops.templates."technitium.env".path];
    environment = {
      "DNS_SERVER_DOMAIN" = "technitium";
      "DNS_SERVER_FORWARDERS" = "1.1.1.1, 8.8.8.8";
      "DNS_SERVER_FORWARDER_PROTOCOL" = "Tcp";
      "DNS_SERVER_LOG_USING_LOCAL_TIME" = "true";
      "DNS_SERVER_WEB_SERVICE_ENABLE_HTTPS" = "false";
    };
    volumes = [
      "/var/lib/homelab/technitium:/etc/dns:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.technitium.rule" = "Host(`dns.c3r5b8.dev`)";
      "traefik.http.services.technitium.loadbalancer.server.url" = "http://192.168.1.2:5380";
    };
    log-driver = "journald";
    extraOptions = [
      # "--network-alias=technitium"
      "--network=host"
      "--cap-add=NET_BIND_SERVICE"
    ];
  };
  systemd.services."podman-technitium" = {
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
