{
  virtualisation.oci-containers = {
    containers = {
      vaultwarden = {
        image = "vaultwarden/server:latest";
        autoStart = true;
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.vaultwarden.rule=Host(`pass.c3r5b8.dev`)"
          "-l=traefik.http.services.vaultwarden.loadbalancer.server.port=80"
        ];
        volumes = [
          "/mnt/fat_ssd/vaultwarden:/data"
        ];
        environment = {
          DOMAIN = "https://pass.c3r5b8.dev";
          WEBSOCKET_ENABLED = "true";
        };
      };
    };
  };
}
