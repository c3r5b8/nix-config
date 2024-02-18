{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops.defaultSopsFile = ../secrets.yaml;
  sops.age.sshKeyPaths = ["/home/c3r5b8/.ssh/id_ed25519"];
  sops.secrets.cloudflareDnsApiCredentials = {};
  sops.secrets.postgres = {};
  sops.secrets.wireguardAntaresKey = {};
}
