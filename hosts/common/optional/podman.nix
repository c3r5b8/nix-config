{
  config,
  pkgs,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    extraPackages = [pkgs.zfs];
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };
  virtualisation.oci-containers = {
    backend = "podman";
  };
}
