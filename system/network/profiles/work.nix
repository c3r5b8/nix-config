{
  pkgs,
  config,
  ...
}: let
  gateway = config.sops.secrets."workVpn/gateway".path;
  user = config.sops.secrets."workVpn/user".path;
  password = config.sops.secrets."workVpn/password".path;
in {
  sops.secrets."workVpn/gateway" = {};
  sops.secrets."workVpn/user" = {};
  sops.secrets."workVpn/password" = {};
  systemd.services.openconnect-fortivpn = {
    after = ["network-online.target"];
    wants = ["network-online.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "openconnect-fortivpn" ''
        gateway=$(${pkgs.coreutils}/bin/tr -d '\n' < ${gateway})
        user=$(${pkgs.coreutils}/bin/tr -d '\n' < ${user})
        exec ${pkgs.openconnect}/bin/openconnect \
          --protocol=fortinet \
          --user="$user" \
          --passwd-on-stdin \
          --non-inter \
          --interface=fortivpn \
          --script=${pkgs.vpnc-scripts}/bin/vpnc-script \
          "$gateway"
      '';
      ExecStartPost = pkgs.writeShellScript "fortivpn-dns" ''
        for i in {1..20}; do
          resolvectl status fortivpn &>/dev/null && break
          sleep 0.5
        done
        resolvectl domain fortivpn '~colobridge.net'
        resolvectl default-route fortivpn no
      '';
      StandardInput = "file:${password}";
      Restart = "on-failure";
    };
  };

  networking.networkmanager.ensureProfiles.profiles.fortivpn = {
    connection = {
      id = "FortiVPN";
      type = "dummy";
      interface-name = "forti-switch";
      autoconnect = false;
    };
    ipv4.method = "disabled";
    ipv6.method = "disabled";
  };

  networking.networkmanager.dispatcherScripts = [
    {
      type = "basic";
      source = pkgs.writeShellScript "fortivpn-switch" ''
        [ "$CONNECTION_ID" = "FortiVPN" ] || exit 0
        case "$NM_DISPATCHER_ACTION" in
          up)   systemctl start openconnect-fortivpn ;;
          down) systemctl stop openconnect-fortivpn ;;
        esac
      '';
    }
  ];
}
