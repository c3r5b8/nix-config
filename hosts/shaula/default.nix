{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    ../../system/users/c3r5b8.nix
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    sharedModules = [inputs.plasma-manager.homeModules.plasma-manager];
    users = {
      c3r5b8 = import ./home.nix;
    };
  };
  nixpkgs.overlays = [
    (final: prev: {
      linux-firmware = prev.linux-firmware.overrideAttrs (old: {
        postInstall = ''
          cp ${./ish_lnlm.bin} $out/lib/firmware/intel/ish/ish_lnlm.bin
        '';
      });
    })
  ];
  networking = {
    hostName = "shaula";
    networkmanager.wifi.powersave = false;
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    sensor.iio.enable = true;
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 5d --keep 5";
    flake = "/home/c3r5b8/dev/nix-config/";
  };
  services.howdy = {
    enable = true;
    control = "sufficient";
  };

  services.linux-enable-ir-emitter.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
  };
  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  nixpkgs.config.allowUnfree = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  environment.systemPackages = [pkgs.kdePackages.plasma-keyboard pkgs.jellyfin-desktop];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
