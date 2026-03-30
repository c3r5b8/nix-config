{
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.age.sshKeyPaths = ["/persist/c3r5b8/home/c3r5b8/.ssh/id_ed25519"];
  sops.secrets.userPassword = {};
  sops.secrets.tailscaleKey = {};
  sops.secrets.userPassword.neededForUsers = true;
  sops.secrets.homelab = {
    sopsFile = ../docker/secrets.env;
    key = "";
    format = "dotenv";
    owner = "root";
    group = "root";
    mode = "0666";
  };
}
