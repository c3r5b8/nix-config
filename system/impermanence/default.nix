{
  pkgs,
  lib,
  ...
}: {
  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount -o noatime,compress-force=zstd:1,discard=async,space_cache=v2 /dev/disk/by-partlabel/disk-nvme0-root /btrfs_tmp

    mkdir -p /btrfs_tmp/old_roots

    if [ -e /btrfs_tmp/@ ]; then
        max_num=$(ls -1 /btrfs_tmp/old_roots 2>/dev/null | sort -n | tail -1)
        if [ -z "$max_num" ]; then
            next=1
        else
            next=$((max_num + 1))
        fi
        mv /btrfs_tmp/@ "/btrfs_tmp/old_roots/$next"
    fi

    delete_subvolume_recursively() {

        # Only proceed if this is a BTRFS subvolume (inode=256)
        if [ $(stat -c %i "$1") -ne 256 ]; then return; fi

        btrfs subvolume list -o "$1" | cut -f 9- -d ' ' |
        while read i; do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    # Keep only the last 15 snapshots, sorted by name (numerical)
    snapshots=$(ls -1 /btrfs_tmp/old_roots 2>/dev/null | sort -n)
    count=$(echo "$snapshots" | wc -l)
    if [ "$count" -gt 15 ]; then
        echo "$snapshots" | head -n $((count - 15)) | while read num; do
            delete_subvolume_recursively "/btrfs_tmp/old_roots/$num"
        done
    fi

    # Create fresh root (or snapshot from blank for better consistency)
    btrfs subvolume create /btrfs_tmp/@

    umount /btrfs_tmp
  '';

  fileSystems."/persist".neededForBoot = true;

  environment.persistence."/persist/system" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/root/.cache/nix"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/var/lib/udisks2"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
  environment.persistence."/persist/c3r5b8" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/home/c3r5b8/desktop"
      "/home/c3r5b8/docs"
      "/home/c3r5b8/downloads"
      "/home/c3r5b8/music"
      "/home/c3r5b8/pictures"
      "/home/c3r5b8/pub"
      "/home/c3r5b8/temp"
      "/home/c3r5b8/videos"
      "/home/c3r5b8/dev"
      "/home/c3r5b8/.ssh"
      "/home/c3r5b8/.config/sops/age"
      "/home/c3r5b8/.local/share/Steam"
      "/home/c3r5b8/.mozilla/"
      "/home/c3r5b8/.local/share/TelegramDesktop/tdata"
      "/home/c3r5b8/.local/share/fish"
      "/home/c3r5b8/.local/share/nvim"
      "/home/c3r5b8/.local/state/nvim"
      # ".config/sunshine"
      # ".config/unity3d"
      # ".config/obsidian"
      # ".factorio"
    ];
  };
  system.activationScripts.bootstrapPersistHome.text = ''
    mkdir -p /persist/c3r5b8
    chown -R c3r5b8:users /persist/c3r5b8
    chmod 0700 /persist/c3r5b8
  '';

  programs.fuse.userAllowOther = true;
}
