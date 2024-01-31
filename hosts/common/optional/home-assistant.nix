{
  virtualisation.oci-containers = {
    containers = {
      homeassistant = {
        image = "ghcr.io/home-assistant/home-assistant:stable";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/homeassistant:/config"
          "/etc/localtime:/etc/localtime:ro"
          "/run/dbus:/run/dbus:ro"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.homeassistant.rule=Host(`ha.c3r5b8.dev`)"
          "-l=traefik.http.services.homeassistant.loadbalancer.server.port=8123"
          "--network host"
        ];
      };
    };
  };
}
