{
  virtualisation.oci-containers = {
    containers = {
      homepage = {
        image = "ghcr.io/gethomepage/homepage:latest";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/homepage:/app/config"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.homepage.rule=Host(`homepage.c3r5b8.dev`)"
          "-l=traefik.http.services.homepage.loadbalancer.server.port=3000"
        ];
      };
    };
  };
}
