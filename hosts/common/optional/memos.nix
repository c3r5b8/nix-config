{
  virtualisation.oci-containers = {
    containers = {
      memos = {
        image = "neosmemo/memos:stable";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/memos:/var/opt/memos"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.memos.rule=Host(`memos.c3r5b8.dev`)"
          "-l=traefik.http.services.memos.loadbalancer.server.port=5230"
        ];
      };
    };
  };
}
