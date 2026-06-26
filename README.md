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

<details>

<summary>First boot setup</summary>

- Setup firefox
  - Log In
  - Setup DarkReader
  - Setup Bitwarden
  - Add css to vimium
  - Add script to tampermonkey
  - Import config in stylus [Catppuccin Userstyles Customizer](https://catppuccin-userstyles-customizer.uncenter.dev)
- Setup telegram
  - Log in
  - Install themes:
    - [Dark](https://t.me/addtheme/ctp_mocha)
    - [Light](https://t.me/addtheme/ctp_latte)
  - Enable qt feame and hw video decoding, disable "Draw attention to the window"

</details>

## Hosts

### Antares (ASUS TUF Gaming B550M-Plus)

- Main desktop
- AMD Ryzen 7 5700X3D
- AMD Radeon RX 7700 XT
- 32GB DDR4

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
