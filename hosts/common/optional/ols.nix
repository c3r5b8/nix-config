{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      couchdb-for-ols = {
        image = "couchdb";
        autoStart = true;
	ports = [
	  "5984:5984"
	];
        volumes = [
          "/mnt/fat_ssd/obsidian-livesync/couchdb-data:/opt/couchdb/data"
          "/mnt/fat_ssd/obsidian-livesync/couchdb-etc:/opt/couchdb/etc/local.d"
        ];
        extraOptions = [
      "-l=traefik.enable=true"
      "-l=traefik.http.routers.couchdb-for-ols.rule=Host(`obsidian.c3r5b8.dev`)"
      "-l=traefik.http.routers.couchdb-for-ols.entrypoints=websecure"
      "-l=traefik.http.routers.couchdb-for-ols.service=couchdb-for-ols"
      "-l=traefik.http.services.couchdb-for-ols.loadbalancer.server.port=5984"
      # - "traefik.http.routers.obsidian-livesync.tls=true"
      # - "traefik.http.routers.obsidian-livesync.tls.certresolver=letsencrypt"
      "-l=traefik.http.routers.couchdb-for-ols.middlewares=obsidiancors"
      "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolallowmethods=GET,PUT,POST,HEAD,DELETE"
      "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolallowheaders=accept,authorization,content-type,origin,referer"
      "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolalloworiginlist=app://obsidian.md,capacitor://localhost,http://localhost"
      "-l=traefik.http.middlewares.obsidiancors.headers.accesscontrolmaxage=3600"
      "-l=traefik.http.middlewares.obsidiancors.headers.addvaryheader=true"
      "-l=traefik.http.middlewares.obsidiancors.headers.accessControlAllowCredentials=true"
          # "-l=traefik.enable=true"
          # "-l=traefik.http.routers.couchdb-for-ols.rule=Host(`obisidan.c3r5b8.dev`)"
          # "-l=traefik.http.services.couchdb-for-ols.loadbalancer.server.port=5984"
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
