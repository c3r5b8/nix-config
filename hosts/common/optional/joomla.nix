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
        image = "joomla";
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
        extraOptions = [
          "--link=db:db"
        ];
      };
    };
  };
}
