# My NixOS config

## Installation

Boot from NixOS installer ISO and then:

```bash
git clone https://github.com/c3r5b8/nix-config
cd nix-config
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko hosts/_host_/disko.nix
sudo mkdir -p /mnt/persist/c3r5b8/home/c3r5b8/.ssh
sudo nano /mnt/persist/c3r5b8/home/c3r5b8/.ssh/id_ed25519
sudo chmod 400 /mnt/persist/c3r5b8/home/c3r5b8/.ssh/id_ed25519
sudo nixos-install --flake .#_host_
```

## Hosts

### Antares (RedmiBook Pro 16 2024)

- Main laptop
- Intel Core Ultra 7 155H
- 32GB LPDDR5X 7467 MT/s

### Shaula (Yoga 7 2-in-1 14ILL10)

- Secondary laptop / Tablet
- Intel Core Ultra 5 226V
- 16GB LPDDR5Х 8533 MT/s

### Acrab (ASRock PRIME A320M-K)

- Work PC
- AMD Ryzen 5 2400G
- 8GB DDR4 2400 MT/s

### Sargas (HP EliteDesk 800 G4 SFF)

- Homeserver
- Intel Core i5-8500
- 16GB DDR4 2666 MT/s
