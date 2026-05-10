{
  networking.networkmanager.ensureProfiles.profiles."homeWifi" = {
    connection = {
      id = "Home WiFi";
      type = "802-11-wireless";
      autoconnect = true;
    };

    "802-11-wireless" = {
      ssid = "$HOME_WIFI_SSID";
      mode = "infrastructure";
    };

    "802-11-wireless-security" = {
      auth-alg = "open";
      key-mgmt = "wpa-psk";
      psk = "$HOME_WIFI_PASSWORD";
    };

    ipv4.method = "auto";
    ipv6.method = "auto";
  };
  networking.networkmanager.ensureProfiles.profiles."homeWifi5" = {
    connection = {
      id = "Home WiFi5";
      type = "802-11-wireless";
      autoconnect = true;
      autoconnect-priority = 100;
    };

    "802-11-wireless" = {
      ssid = "$HOME_WIFI5_SSID";
      mode = "infrastructure";
    };

    "802-11-wireless-security" = {
      auth-alg = "open";
      key-mgmt = "wpa-psk";
      psk = "$HOME_WIFI_PASSWORD";
    };

    ipv4.method = "auto";
    ipv6.method = "auto";
  };
}
