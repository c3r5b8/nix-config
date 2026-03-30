{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Apacer_AS2280P4_256GB_AB20230630A0100559";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["defaults"];
              };
            };

            root = {
              name = "root";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "noatime"
                      "compress-force=zstd:1"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "noatime"
                      "compress-force=zstd:1"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "noatime"
                      "compress-force=zstd:1"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                };
              };
            };
          };
        };
      };
      media = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CT2000P5SSD8_202228691C92";
        content = {
          type = "gpt";
          partitions = {
            media = {
              name = "media";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt/media";
              };
            };
          };
        };
      };
    };
  };
}
