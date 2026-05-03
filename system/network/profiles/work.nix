{
  networking.networkmanager.ensureProfiles.profiles."work" = {
    connection = {
      id = "Work";
      type = "vpn";
      autoconnect = false;
      uuid = "ee12011e-2cc5-4e45-b66e-1c1f6e11e5fe";
    };

    vpn = {
      "service-type" = "org.freedesktop.NetworkManager.l2tp";
      gateway = "$VPN_GATEWAY";
      user = "$VPN_USER";
      "password-flags" = 0;
      "ipsec-enabled" = "yes";
      "ipsec-psk-flags" = 0;
    };

    "vpn-secrets" = {
      password = "$VPN_PASSWORD";
      "ipsec-psk" = "$VPN_PSK";
    };

    ipv4 = {
      method = "auto";
    };

    ipv6 = {
      method = "auto";
    };
  };
}
