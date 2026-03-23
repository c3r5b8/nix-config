{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "ax3200 proxmox" = {
        user = "root";
      };

      "sargas acrab shaula antares" = {
        user = "c3r5b8";
      };

      "rose vm-traefik" = {
        user = "sas";
      };

      "vm-moodle" = {
        hostname = "10.4.0.21";
        user = "sas";
        proxyJump = "vm-traefik";
      };

      "vm-monitoring" = {
        hostname = "10.4.0.23";
        user = "sas";
        proxyJump = "vm-traefik";
      };

      "vm-eprints" = {
        hostname = "10.4.0.24";
        user = "sas";
        proxyJump = "vm-traefik";
      };

      "vm-testing" = {
        hostname = "10.4.0.26";
        user = "c3r5b8";
        proxyJump = "vm-traefik";
      };

      "vm-koha" = {
        hostname = "10.4.0.27";
        user = "koha";
        proxyJump = "vm-traefik";
      };
    };
  };
}
