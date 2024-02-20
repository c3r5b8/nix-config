{
  virtualisation.oci-containers = {
    containers = {
      db = {
        image = "mariadb:10.2";
        environment = {
          MYSQL_ROOT_PASSWORD = "admin";
          MYSQL_USER = "joomla";
          MYSQL_PASSWORD = "joomla";
          MYSQL_DATABASE = "joomla";
        };
      };
      web = {
        image = "terrychu/joomla-without-database:3.8.1";
        # links:
        #   - db:db
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.joomla.rule" = "Host(`web.c3r5b8.dev`)";
          "traefik.http.services.joomla.loadbalancer.server.port" = "80";
        };
        environment = {
          DB_HOST = "db";
          DB_USER = "joomla";
          DB_PASSWORD = "joomla";
          DB_NAME = "joomla";
        };
        extraOptions = [
          "--link=db:db"
        ];
      };
    };
  };
}
