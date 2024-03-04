{
  virtualisation.oci-containers = {
    containers = {
      db = {
        image = "mariadb:latest";
        environment = {
          MYSQL_ROOT_PASSWORD = "admin";
          MYSQL_USER = "joomla";
          MYSQL_PASSWORD = "joomla";
          MYSQL_DATABASE = "joomla";
        };
        volumes = [
          "/mnt/fat_ssd/joomla/db:/var/lib/mysql"
        ];
      };
      web = {
        image = "joomla:5-php8.1-apache";
        # links:
        #   - db:db
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.joomla.rule" = "Host(`web.c3r5b8.dev`)";
          "traefik.http.services.joomla.loadbalancer.server.port" = "80";
        };
        environment = {
          JOOMLA_DB_HOST = "db";
          DB_USER = "joomla";
          JOOMLA_DB_PASSWORD = "admin";
          DB_NAME = "joomla";
        };
        volumes = [
          "/mnt/fat_ssd/joomla/code:/var/www/html"
        ];
        extraOptions = [
          "--link=db:db"
        ];
      };
    };
  };
}
