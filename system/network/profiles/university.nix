{
  networking.networkmanager.ensureProfiles.profiles."zu.edu.ua" = {
    connection = {
      id = "zu.edu.ua";
      type = "802-11-wireless";
      autoconnect = true;
    };
    "802-11-wireless" = {
      ssid = "zu.edu.ua";
      mode = "infrastructure";
    };

    "802-11-wireless-security" = {
      key-mgmt = "none";
    };

    ipv4 = {
      method = "auto";
    };

    ipv6 = {
      method = "auto";
    };
  };
}
