{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./fish.nix
    ./fonts.nix
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./sops.nix
  ];
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    iputils
  ];
  services.fstrim.enable = true;
}
