{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers = {
    containers = {
      nextcloud = {
        image = "nextcloud:fpm";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/nextcloud/data:/var/www/html"
        ];
        extraOptions = [
          "--network=container:postgres"
        ];
        environment = {
          POSTGRES_USER = "postgres";
          POSTGRES_DB = "nextcloud";
          POstGRES_HOST = "postgres";
        };
        environmentFiles = [
          config.sops.secrets.postgres.path
        ];
      };
      postgres = {
        image = "postgres:12-alpine";
        autoStart = true;
        hostname = "postgres";
        volumes = [
          "/mnt/fat_ssd/nextcloud/db:/var/lib/postgresql/data"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.nextcloud.rule=Host(`cloud.c3r5b8.dev`)"
          "-l=traefik.http.services.nextcloud.loadbalancer.server.port=80"
        ];
        environment = {
          # POSTGRES_PASSWORD = "postgres";
          POSTGRES_USER = "postgres";
          POSTGRES_DB = "nextcloud";
          POSTGRES_INITDB_ARGS = "--encoding=UTF-8 --lc-collate=C --lc-ctype=C";
        };
        environmentFiles = [
          config.sops.secrets.postgres.path
        ];
      };
    };
  };
}
