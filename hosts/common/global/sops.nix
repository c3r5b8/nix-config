{
  inputs,...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../secrets.yaml;
  sops.age.sshKeyPaths = [ "/home/c3r5b8/.ssh/id_ed25519" ];
  sops.secrets.c3r5b8_pass = {};
}