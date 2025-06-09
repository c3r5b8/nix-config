{
  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    age.keyFile = "/persist/home/.config/sops/age/keys.txt";
    age.sshKeyPaths = ["/persist/home/.ssh/id_ed25519"];
    secrets = {
      userPassword = {neededForUsers = true;};
    };
  };
}
