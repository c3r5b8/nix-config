{
  inputs,
  outputs,
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
}
