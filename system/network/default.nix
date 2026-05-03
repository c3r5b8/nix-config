{
  pkgs,
  config,
  ...
}: {
  services.strongswan = {
    enable = true;
  };
  environment.etc."strongswan.conf".text = '''';
  systemd.tmpfiles.rules = [
    "d /etc/ipsec.d 0755 root root -"
    "f /etc/ipsec.d/ipsec.nm-l2tp.secrets 0600 root root -"
  ];

  environment.etc."ipsec.secrets".text = ''
    include ipsec.d/ipsec.nm-l2tp.secrets
  '';
  services.strongswan.secrets = [
    "ipsec.d/ipsec.nm-l2tp.secrets"
  ];

  sops.templates."networkmanager.env" = {
    content = ''
      VPN_USER=${config.sops.placeholder."vpnUser"}
      VPN_PASSWORD=${config.sops.placeholder."vpnPassword"}
      VPN_PSK=${config.sops.placeholder."vpnPsk"}
      VPN_GATEWAY=${config.sops.placeholder."vpnGateway"}
      HOME_WIFI_PASSWORD=${config.sops.placeholder."wifiPassword"}
      HOME_WIFI_SSID=${config.sops.placeholder."wifiSsid"}
      HOME_WIFI5_SSID=${config.sops.placeholder."wifi5Ssid"}
    '';
  };

  sops.secrets = {
    "vpnGateway" = {};
    "vpnUser" = {};
    "vpnPassword" = {};
    "vpnPsk" = {};
    "wifiPassword" = {};
    "wifiSsid" = {};
    "wifi5Ssid" = {};
  };

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
    ];
    ensureProfiles = {
      environmentFiles = [config.sops.templates."networkmanager.env".path];
    };
  };
  imports = [
    ./profiles/work.nix
  ];
}
