{
  virtualisation.oci-containers.containers = {
    freshrss = {
      image = "freshrss/freshrss";
      autoStart = true;
      volumes = [
        "/mnt/fat_ssd/freshrss/data:/var/www/FreshRSS/data"
        "/mnt/fat_ssd/freshrss/extensions:/var/www/FreshRSS/extensions"
      ];
      environment = {
        SERVER_DNS = "rss.c3r5b8.dev";
        TZ = "Europe/Kyiv";
        CRON_MIN = "*/15";
      };
      extraOptions = [
        "-l=traefik.enable=true"
        "-l=traefik.http.routers.freshrss.rule=Host(`rss.c3r5b8.dev`)"
        "-l=traefik.http.services.freshrss.loadbalancer.server.port=8080"
      ];
    };
  };
}
