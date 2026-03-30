{
  pkgs,
  config,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    enableOnBoot = true;
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
  };

  environment.etc."stacks/homelab/compose.yaml".source = ./docker-compose.yaml;
  systemd.services.homelab-docker-compose = {
    description = "My plain old docker-compose stack";
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket" "network-online.target"];
    requires = ["docker.service" "network-online.target"];
    path = [pkgs.docker];

    restartTriggers = [config.environment.etc."stacks/homelab/compose.yaml".source];
    preStart = ''
      mkdir -p /var/lib/homelab/traefik
      touch /var/lib/homelab/traefik/acme.json
      chmod 600 /var/lib/homelab/traefik/acme.json
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.docker}/bin/docker compose -f /etc/stacks/homelab/compose.yaml --env-file ${config.sops.secrets.homelab.path} up -d --remove-orphans";
      ExecStop = "${pkgs.docker}/bin/docker compose -f /etc/stacks/homelab/compose.yaml down";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [53 80 443 8080];
    allowedUDPPorts = [53 443];
  };

  environment.persistence."/persist/system".directories = [
    "/var/lib/docker"
    "/var/lib/homelab"
  ];
}
