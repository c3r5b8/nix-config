{
  imports = [
    ../../modules/nixos/system/boot.nix
    ../../modules/nixos/system/locale.nix
    ../../modules/nixos/system/network.nix
    ../../modules/nixos/system/security.nix
    ../../modules/nixos/system/sops.nix

    ../../modules/nixos/services/ssh.nix
    ../../modules/nixos/services/tailscale.nix
  ];

  mySystem.homeManagerProfiles = [../../profiles/hm/cli.nix];
}
