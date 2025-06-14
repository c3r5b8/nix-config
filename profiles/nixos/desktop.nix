{
  imports = [
    ../../modules/nixos/system/bluetooth.nix
    ../../modules/nixos/system/fonts.nix
    ../../modules/nixos/system/adb.nix
    ../../modules/nixos/system/steam.nix

    ../../modules/nixos/services/greetd.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/power.nix
  ];

  mySystem.homeManagerProfiles = [../../profiles/hm/desktop.nix];
}
