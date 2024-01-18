{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-laptop

    ./hardware-configuration.nix

    ../common/global
    ../common/users/c3r5b8

    ../common/optional/quietboot.nix
    ../common/optional/disable-nvidia.nix
    ../common/optional/bluetooth.nix
    ../common/optional/pipewire.nix
    ../common/optional/wayland.nix
  ];
  networking = {
    hostName = "antares";
  };
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = ["aarch64-linux" "i686-linux"];
  };
  services.gnome.gnome-keyring.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  networking.networkmanager.enable = true;
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  system.stateVersion = "23.11";
}
