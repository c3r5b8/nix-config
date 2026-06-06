{config, ...}: {
  sops.templates."networkmanager.env" = {
    content = ''
      HOME_WIFI_PASSWORD=${config.sops.placeholder."wifiPassword"}
      HOME_WIFI_SSID=${config.sops.placeholder."wifiSsid"}
      HOME_WIFI5_SSID=${config.sops.placeholder."wifi5Ssid"}
    '';
  };

  sops.secrets = {
    "wifiPassword" = {};
    "wifiSsid" = {};
    "wifi5Ssid" = {};
  };

  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      environmentFiles = [config.sops.templates."networkmanager.env".path];
    };
  };
  networking.firewall.allowedTCPPorts = [5201];
  networking.firewall.allowedUDPPorts = [5201];
  imports = [
    ./profiles/home.nix
    ./profiles/university.nix
  ];
}
