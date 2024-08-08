{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/main.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
          	["bluez5.enable-hw-volume"] = false,
          }
        '')
      ];
    };
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
