{config, ...}: {
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.age.sshKeyPaths = ["/persist/c3r5b8/home/c3r5b8/.ssh/id_ed25519"];
  sops.secrets.userPassword = {};
  sops.secrets.userPassword.neededForUsers = true;

  sops.secrets."workRdp/user" = {
    owner = config.users.users.c3r5b8.name;
    group = config.users.users.c3r5b8.group;
  };
  sops.secrets."workRdp/domain" = {
    owner = config.users.users.c3r5b8.name;
    group = config.users.users.c3r5b8.group;
  };
  sops.secrets."workRdp/password" = {
    owner = config.users.users.c3r5b8.name;
    group = config.users.users.c3r5b8.group;
  };
}
