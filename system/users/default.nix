{config, ...}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.c3r5b8 = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.userPassword.path;
    # initialPassword = "1";
    extraGroups = ifTheyExist [
      "audio"
      "i2c"
      "networkmanager"
      "adbusers"
      "libvirtd"
      "plugdev"
      "video"
      "wheel"
    ];
  };
}
