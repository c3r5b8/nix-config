{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "ESP";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              extraOpenArgs = [];
              settings = {
                allowDiscards = true;
              };
              content = {
                type = "lvm_pv";
                vg = "root_vg";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      root_vg = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "32G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];

              subvolumes = {
                "/root" = {
                  mountOptions = ["subvol=root" "compress=zstd" "ssd" "space_cache=v2" "noatime"];
                  mountpoint = "/";
                };

                "/home" = {
                  mountOptions = ["subvol=home" "compress=zstd" "ssd" "space_cache=v2" "noatime"];
                  mountpoint = "/home";
                };

                "/nix" = {
                  mountOptions = ["subvol=nix" "compress=zstd" "ssd" "space_cache=v2" "noatime"];
                  mountpoint = "/nix";
                };
                "/log" = {
                  mountOptions = ["subvol=log" "compress=zstd" "ssd" "space_cache=v2" "noatime"];
                  mountpoint = "/var/log";
                };
              };
            };
          };
        };
      };
    };
  };
}
