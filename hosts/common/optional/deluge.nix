{
  virtualisation.oci-containers = {
    containers = {
      deluge = {
        image = "linuxserver/deluge:latest";
        autoStart = true;
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.deluge.rule=Host(`deluge.c3r5b8.dev`)"
          "-l=traefik.http.services.deluge.loadbalancer.server.port=8112"
        ];
        volumes = [
          "/mnt/fat_ssd/Media:/data/completed"
          "/mnt/fat_ssd/deluge:/config"
        ];
        environment = {
          TZ = "Europe/Kyiv";
        };
      };
    };
  };
}
