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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrGeP6Qe0seU9JJe1wiTY7/mpfRcoZPfHt70MZQ/Raq c3r5b8@antares"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL1GRusiqCwdhdksxl1Of0xi+cYOVMo7ipvx58ZT44k7 c3r5b8@acrab"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOE6+pFtIyCjiuhKw7UOtBsMV1VmXCLMJm1wpg7jZay c3r5b8@shaula"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIErdNJIs3/2rgAuKgihmocXqWGtYkjd24YrVjREuvTca c3r5b8@shaula"
    ];
  };
}
