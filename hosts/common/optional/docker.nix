{
  config,
  pkgs,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    
    # dockerCompat = true;
    # extraPackages = [pkgs.zfs];
    # dockerSocket.enable = true;
    # defaultNetwork.settings = {
    #   dns_enabled = true;
    # };
  };
  virtualisation.oci-containers = {
    backend = "docker";
  };
}
