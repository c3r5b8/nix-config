{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      couchdb-for-ols = {
        image = "couchdb";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/obsidian-livesync/couchdb-data:/opt/couchdb/data"
          "/mnt/fat_ssd/obsidian-livesync/couchdb-etc:/opt/couchdb/etc/local.d"
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.couchdb-for-ols.rule=Host(`obisidan.c3r5b8.dev`)"
          "-l=traefik.http.services.couchdb-for-ols.loadbalancer.server.port=5984"
        ];
        environment = {
          COUCHDB_USER = "c3r5b8";
        };
        environmentFiles = [
          config.sops.secrets.obsidianLiveSync.path
        ];
      };
    };
  };
}
# COUCHDB_PASSWORD=${password}

