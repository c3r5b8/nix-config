{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    ../../system/users
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      c3r5b8 = import ./home.nix;
    };
  };
  environment.etc."modprobe.d/amd_sfh.conf".text = ''
    options amd_sfh sensor_mask=1
  '';
  networking.hostName = "shaula";
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  hardware.sensor.iio.enable = true;
  #  hardware = {
  #    bluetooth = {
  #      enable = true;
  #      powerOnBoot = true;
  #    };
  #  };
  boot.blacklistedKernelModules = ["hid_sensor_custom"];
  boot.kernelParams = [
    "hid_sensor_hub.force_generic_accel_usage_id=1"
  ];
  services = {
    blueman.enable = true;
  };
  # environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable

  nixpkgs.config.allowUnfree = true;

  # programs.sway.enable = true;
  programs.firefox.enable = true;
  programs.neovim.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}
