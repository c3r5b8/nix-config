{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers = {
    containers = {
      synapse = {
        image = "docker.io/matrixdotorg/synapse:latest";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/synapse/data:/data"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.ntfy.rule=Host(`matrix.c3r5b8.dev`)"
          "-l=traefik.http.services.ntfy.loadbalancer.server.port=8008"
        ];
        environment = {
          SYNAPSE_CONFIG_PATH = "/data/homeserver.yaml";
        };
      };
      postgres = {
        image = "postgres:12-alpine";
        autoStart = true;
        hostname = "postgres";
        volumes = [
          "/mnt/fat_ssd/synapse/db:/var/lib/postgresql/data"
        ];
        environment = {
          # POSTGRES_PASSWORD = "postgres";
          POSTGRES_USER = "postgres";
          POSTGRES_DB = "synapse";
          POSTGRES_INITDB_ARGS = "--encoding=UTF-8 --lc-collate=C --lc-ctype=C";
        };
        environmentFiles = [
          config.sops.secrets.postgres.path
        ];
      };
    };
  };
}
