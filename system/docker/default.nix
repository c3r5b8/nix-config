{config, ...}: {
  imports = [./homelab];
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  networking.firewall.interfaces = let
    matchAll =
      if !config.networking.nftables.enable
      then "podman+"
      else "podman*";
  in {
    "${matchAll}".allowedUDPPorts = [53];
  };

  # enable autoupdates
  systemd.timers."podman-auto-update".wantedBy = ["timers.target"];

  virtualisation.oci-containers.backend = "podman";
  environment.persistence."/persist/system".directories = [
    "/var/lib/containers"
    "/var/lib/homelab"
  ];
}
