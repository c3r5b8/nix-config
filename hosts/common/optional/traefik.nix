{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      traefik = {
        image = "traefik";
        autoStart = true;
        cmd = [
	  "--log.level=DEBUG"
          "--api.insecure=true"
          "--providers.docker=true"
          "--providers.docker.exposedbydefault=false"
          "--entrypoints.web.address=:80"
          "--certificatesresolvers.letsencrypt.acme.dnschallenge=true"
          "--certificatesresolvers.letsencrypt.acme.dnschallenge.provider=cloudflare"
          "--certificatesresolvers.letsencrypt.acme.email=olespid@gmail.com"
          # HTTP
          "--entrypoints.web.address=:80"
          "--entrypoints.web.http.redirections.entrypoint.to=websecure"
          "--entrypoints.web.http.redirections.entrypoint.scheme=https"
          "--entrypoints.websecure.address=:443"
          # HTTPS
          "--entrypoints.websecure.http.tls=true"
          "--entrypoints.websecure.http.tls.certResolver=letsencrypt"
          "--entrypoints.websecure.http.tls.domains[0].main=c3r5b8.dev"
          "--entrypoints.websecure.http.tls.domains[0].sans=*.c3r5b8.dev"
        ];
        extraOptions = [
          # Proxying Traefik itslef
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.traefik.rule=Host(`proxy.c3r5b8.dev`)"
          "-l=traefik.http.services.traefik.loadbalancer.server.port=8080"
	  "--add-host=host.docker.internal:host-gateway"
#	  "--add-host=host.docker.internal:172.17.0.1"
#	  "--network=host"
        ];
        ports = [
          "443:443"
          "80:80"
        ];
        environmentFiles = [
          config.sops.secrets.cloudflareDnsApiCredentials.path
        ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock:ro"
          "/mnt/fat_ssd/traefik/acme.json:/acme.json"
        ];
      };
    };
  };
}
