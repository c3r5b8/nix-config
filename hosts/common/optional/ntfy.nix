{
  virtualisation.oci-containers = {
    containers = {
      ntfy = {
        image = "binwiederhier/ntfy";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/cache/ntfy:/var/cache/ntfy"
          "/mnt/fat_ssd/ntfy:/etc/ntfy"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.ntfy.rule=Host(`ntfy.c3r5b8.dev`)"
          "-l=traefik.http.services.ntfy.loadbalancer.server.port=80"
        ];
        cmd = ["serve"];
        environment = {
          TZ = "Europe/Kyiv";
        };
      };
    };
  };
}
