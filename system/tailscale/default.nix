{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
  # NOTE: fix for https://github.com/tailscale/tailscale/issues/4254
  services.resolved.enable = true;

  environment.persistence."/persist/system".directories = [
    "/var/lib/tailscale"
  ];
}
