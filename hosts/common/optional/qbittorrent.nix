{
  virtualisation.oci-containers = {
    containers = {
      qbittorrent = {
        image = "lscr.io/linuxserver/qbittorrent:latest";
        autoStart = true;
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.qbittorrent.rule=Host(`qbittorrent.c3r5b8.dev`)"
          "-l=traefik.http.services.qbittorrent.loadbalancer.server.port=8080"
        ];
        ports = [
          "6881:6881"
          "6881:6881/udp"
        ];
        volumes = [
          "/mnt/fat_ssd/Media:/data/completed"
          "/mnt/fat_ssd/deluge:/config"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          WEBUI_PORT = "8080";
          TZ = "Europe/Kyiv";
        };
      };
    };
  };
}
