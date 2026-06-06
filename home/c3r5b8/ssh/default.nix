{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "ax3200 proxmox" = {
        User = "root";
      };
      "sargas acrab shaula antares" = {
        User = "c3r5b8";
      };

      "rose vm-traefik" = {
        User = "sas";
      };

      "vm-moodle" = {
        HostName = "10.4.0.21";
        User = "sas";
        ProxyJump = "vm-traefik";
      };

      "vm-monitoring" = {
        HostName = "10.4.0.23";
        User = "sas";
        ProxyJump = "vm-traefik";
      };

      "vm-eprints" = {
        HostName = "10.4.0.24";
        User = "sas";
        ProxyJump = "vm-traefik";
      };

      "vm-testing" = {
        HostName = "10.4.0.26";
        User = "c3r5b8";
        ProxyJump = "vm-traefik";
      };

      "vm-koha" = {
        HostName = "10.4.0.27";
        User = "koha";
        ProxyJump = "vm-traefik";
      };
    };
  };
}
