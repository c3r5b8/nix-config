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
    ../common/optional/sunshine.nix
    ../common/optional/docker.nix
    ../common/optional/powersave.nix
  ];

  services.xserver.videoDrivers = ["amdgpu"];
  networking = {
    hostName = "antares";
    firewall = {
      allowedUDPPorts = [12123 22000 21027];
    };
    wg-quick.interfaces.wg0 = {
      address = ["192.168.2.3/24"];
      dns = ["192.168.1.1"];
      privateKeyFile = config.sops.secrets.wireguardAntaresKey.path;

      peers = [
        {
          publicKey = "RpvucUSN/l+hYhmslCfiAI4aR5wAz6zyts9Y1LiG4wg=";
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "46.219.25.174:12123";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = ["aarch64-linux" "i686-linux"];
  };
  services.gnome.gnome-keyring.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  services = {
    syncthing = {
      enable = true;
      user = "c3r5b8";
      dataDir = "/home/c3r5b8/Documents"; # Default folder for new synced folders
      configDir = "/home/c3r5b8/Documents/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
  networking.firewall.allowedTCPPorts = [8384 22000];
  # networking.firewall.allowedUDPPorts = [];
  networking.networkmanager.enable = true;
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  system.stateVersion = "23.11";
}
