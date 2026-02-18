{
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.age.sshKeyPaths = ["/persist/c3r5b8/home/c3r5b8/.ssh/id_ed25519"];
  sops.secrets.userPassword = {};
  sops.secrets.userPassword.neededForUsers = true;
}
