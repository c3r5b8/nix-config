{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix

    ../../system
    ../../system/desktop.nix
    ../../system/users/c3r5b8.nix

    ../../system/bluetooth
  ];
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      theme = config.custom.theme;
    };
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users = {
      c3r5b8 = import ./home.nix;
    };
  };
  nixpkgs.overlays = [
    inputs.nur.overlays.default
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
  hardware.sensor.iio.enable = true;
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
  programs.gtklock = {
    modules = with pkgs; [
      gtklock-virtkb-module
    ];
  };
  services.logind.settings.Login.HandlePowerKey = "suspend";
  services.linux-enable-ir-emitter.enable = true;
  programs.sway.enable = true;
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
