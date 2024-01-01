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
  environment.systemPackages = with pkgs; [
    iputils
  ];
}
