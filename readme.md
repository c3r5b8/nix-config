## Setup
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko hosts/
sudo nixos-install --root /mnt --flake .#
```
