{
  virtualisation.oci-containers = {
    containers = {
      factorio = {
        image = "factoriotools/factorio";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/factorio:/factorio"
        ];
        ports = [
          "34197:34197/udp"
        ];
        environment = {
          TZ = "Europe/Kyiv";
        };
      };
    };
  };
}
