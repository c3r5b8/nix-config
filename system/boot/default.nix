{pkgs, ...}: {
  boot = {
    bootspec.enable = true;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
      timeout = 0;
      efi = {
        canTouchEfiVariables = true;
      };
    };
    plymouth = {
      enable = true;
    };
    # kernelPackages = pkgs.linuxPackages_testing;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "splash"
      "plymouth.use-simpledrm"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}
