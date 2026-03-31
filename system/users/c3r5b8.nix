{
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  programs.fish.enable = true;
  users.users.c3r5b8 = {
    isNormalUser = true;
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets.userPassword.path;
    extraGroups = ifTheyExist [
      "audio"
      "i2c"
      "input"
      "networkmanager"
      "adbusers"
      "libvirtd"
      "plugdev"
      "video"
      "wheel"
    ];
  };
}
