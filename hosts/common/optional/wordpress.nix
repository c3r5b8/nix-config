{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      db = {
        hostname = "db";
        image = "mariadb:10.6.4-focal";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/wordpress/db:/var/lib/mysql"
        ];
        environment = {
          MYSQL_DATABASE = "wordpress";
          MYSQL_USER = "wordpress";
        };
        environmentFiles = [
          config.sops.secrets.wordpressDbEnv.path
        ];
      };
      wordpress = {
        image = "wordpress:latest";
        volumes = [
          "/mnt/fat_ssd/wordpress/data:/var/www/html"
        ];
        environment = {
          WORDPRESS_DB_HOST = "db";
          WORDPRESS_DB_USER = "wordpress";
          # WORDPRESS_DB_PASSWORD="wordpress";
          WORDPRESS_DB_NAME = "wordpress";
        };
        environmentFiles = [
          config.sops.secrets.wordpressEnv.path
        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.wordpress.rule=Host(`wp.c3r5b8.dev`)"
          "-l=traefik.http.services.wordpress.loadbalancer.server.port=80"
        ];
      };
    };
  };
}
