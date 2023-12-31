# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd = {
      availableKernelModules = ["xhci_pci" "nvme"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd" "noatime" "ssd" "space_cache=v2"];
    };

    "/home" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd" "noatime" "ssd" "space_cache=v2"];
    };

    "/nix" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime" "ssd" "space_cache=v2"];
    };

    "/var/log" = {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = ["subvol=log" "compress=zstd" "noatime" "ssd" "space_cache=v2"];
      neededForBoot = true;
    };

    "/mnt/fat_ssd" = {
      device = "/dev/nvme0n1p1";
      fsType = "btrfs";
      options = ["compress=zstd" "noatime" "ssd" "space_cache=v2"];
    };

    ${config.boot.loader.efi.efiSysMountPoint} = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };
  swapDevices = [{device = "/dev/disk/by-label/swap";}];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
