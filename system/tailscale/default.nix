{config, ...}: {
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.sops.secrets.tailscaleKey.path;
  };

  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };

  # NOTE: fix for https://github.com/tailscale/tailscale/issues/4254
  services.resolved.enable = true;

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  environment.persistence."/persist/system".directories = [
    "/var/lib/tailscale"
  ];
}
