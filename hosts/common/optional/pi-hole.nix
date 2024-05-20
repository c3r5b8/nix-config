{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      pihole = {
        image = "pihole/pihole:latest";
        autoStart = true;

        # For DHCP it is recommended to remove these ports and instead add: network_mode: "host"
        ports = [
          "53:53/tcp"
          "53:53/udp"
          "67:67/udp"
          # "80:80/tcp"
        ];
        environment = {
          TZ = "Europe/Kyiv";
        };
        extraOptions = [
          # Proxying Traefik itslef
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.pihole.rule=Host(`pihole.c3r5b8.dev`)"
          "-l=traefik.http.services.pihole.loadbalancer.server.port=80"
        ];
        # WEBPASSWORD: 'set a secure password here or it will be random'
        # Volumes store your data between container upgrades
        volumes = [
          "/mnt/fat_ssd/pihole/etc-pihole:/etc/pihole/"
          "/mnt/fat_ssd/pihole/etc-dnsmasq.d:/etc/dnsmasq.d/"
        ];
        environmentFiles = [
          config.sops.secrets.piHole.path
        ];

        #   https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
        # cap_add:
        # - NET_ADMIN # Required if you are using Pi-hole as your DHCP server, else not needed
        # restart: unless-stopped
      };
    };

  };
}
