{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      db = {
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
        # ports:
        #   - 80:80
        # restart: always
        environment = {
          WORDPRESS_DB_HOST = "db";
          WORDPRESS_DB_USER = "wordpress";
          # WORDPRESS_DB_PASSWORD="wordpress";
          WORDPRESS_DB_NAME = "wordpress";
        };
        environmentFiles = [
          config.sops.secrets.wordpressEnv.path
        ];
      };
    };
  };
}