{
  virtualisation.oci-containers = {
    containers = {
      redlib = {
        image = "quay.io/redlib/redlib:latest";
        autoStart = true;
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.redlib.rule=Host(`redlib.c3r5b8.dev`)"
          "-l=traefik.http.services.redlib.loadbalancer.server.port=8080"
        ];
      };
    };
  };
}
