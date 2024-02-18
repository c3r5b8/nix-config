{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.sshKeyPaths = ["/home/c3r5b8/.ssh/id_ed25519"];
    secrets = {
      cloudflareDnsApiCredentials = {};
      postgres = {};
      wireguardAntaresKey = {};
    };
  };
  systemd.services.force-rebuild-sops-hack = {
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = ''
        /run/current-system/activate
      '';
      Type = "oneshot";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
