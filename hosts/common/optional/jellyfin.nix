{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      jellyfin = {
        image = "lscr.io/linuxserver/jellyfin";
        autoStart = true;
        volumes = [
          "/mnt/fat_ssd/Media/TV:/data/tvshows"
          "/mnt/fat_ssd/Media/Movies:/data/movies"
          "/mnt/fat_ssd/jellyfin:/config"
        ];
        environment = {
          TZ = "Europe/Kyiv";
        };
      };
    };
  };
}
