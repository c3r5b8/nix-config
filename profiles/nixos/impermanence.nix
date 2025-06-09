{
  imports = [../../modules/nixos/system/impermanence.nix];

  mySystem.homeManagerProfiles = [../../profiles/hm/impermanence.nix];
}
