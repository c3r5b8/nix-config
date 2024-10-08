{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.c3r5b8 = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups =
      ["wheel" "video" "audio" "dialout"]
      ++ ifTheyExist [
        "network"
        "docker"
        "wireshark"
        "i2c"
        "mysql"
        "git"
        "libvirtd"
        "deluge"
      ];
    packages = [pkgs.home-manager pkgs.firefox pkgs.gnupg pkgs.fish pkgs.git];
    password = "changeme";
  };
  services.geoclue2.enable = true;
}
