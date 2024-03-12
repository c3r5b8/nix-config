{pkgs,...}:{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    oci-containers = {
      backend = "podman";
    };
  };
  systemd = {
    services = {
      podman-out = {
        enable = true;
        description = "Send podman socet in network";
        script = "${pkgs.podman}/bin/podman system service --time=0 tcp://0.0.0.0:37017";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  };
  networking = {
    firewall = {
      allowedTCPPorts = [ 37017 ];
    };
  };
}
