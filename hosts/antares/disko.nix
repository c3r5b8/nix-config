{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CT1000P3PSSD8_2250E6922DD1";
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
      nvme1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CT2000P3SSD8_2342E8810C87";
        content = {
          type = "gpt";
          partitions = {
            games = {
              name = "games";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@" = {
                    mountpoint = "/games";
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
    };
  };
}
