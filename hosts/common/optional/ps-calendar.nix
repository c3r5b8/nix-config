{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      calendar = {
        image = "c3r5b8/ps-calendar:latest";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/calendar:/data/calendar"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.calendar.rule=Host(`calendar.c3r5b8.dev`)"
          "-l=traefik.http.services.calendar.loadbalancer.server.port=3000"
        ];
        environment = {
          SQLITE_DB = "/data/calendar/test.db";
          PORT = "3000";
          URL = "http://localhost:3000";
          PS_ROZKLAD_API_URL = "https://dekanat.zu.edu.ua/";
          # TZ = "Europe/Kyiv";
        };
        environmentFiles = [
          config.sops.secrets.googleClientId.path
          config.sops.secrets.googleClientSecret.path
          # config.sops.secrets.psCalendar.path
        ];
      };
    };
  };
}
