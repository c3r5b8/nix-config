{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    supportedFilesystems = ["ntfs"];

    initrd = {
      availableKernelModules =
        ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"]
        ++ config.boot.initrd.luks.cryptoModules;
      kernelModules = ["dm-snapshot" "amdgpu"];
      luks.devices.luksroot = {
        device = "/dev/disk/by-label/cryptroot";
        preLVM = true;
        allowDiscards = true;
      };
    };
    kernelModules = ["kvm-amd"];
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

    ${config.boot.loader.efi.efiSysMountPoint} = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [{device = "/dev/disk/by-label/swap";}];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
