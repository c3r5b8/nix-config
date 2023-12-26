{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers = {
    containers = {
      jellyfin = {
        image = "docker.io/jellyfin/jellyfin:latest";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/Media/TV:/data/tvshows"
          "/mnt/fat_ssd/Media/Movies:/data/movies"
          "/mnt/fat_ssd/jellyfin:/config"
        ];
#        ports = [
#          "8096:8096"
#        ];
        extraOptions = [
          "-l=traefik.enable=true"
          "-l=traefik.http.routers.jellyfin.rule=Host(`jellyfin.c3r5b8.dev`)"
          "-l=traefik.http.services.jellyfin.loadbalancer.server.port=8096"
        ];
        environment = {
          TZ = "Europe/Kyiv";
        };
      };
    };
  };
  # environment.systemPackages = [
  #   pkgs.jellyfin
  #   pkgs.jellyfin-web
  #   pkgs.jellyfin-ffmpeg
  # ];

  # services.jellyfin = {
  #   enable = true;
  #   openFirewall = true;
  # };
}
