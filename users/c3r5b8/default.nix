{
  config,
  inputs,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.c3r5b8 = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.userPassword.path;
    # initialPassword = "1";
    extraGroups = ifTheyExist [
      "audio"
      "i2c"
      "network"
      "adbusers"
      "plugdev"
      "video"
      "wheel"
    ];
  };
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      # "c3r5b8" = import ./home.nix;
      "c3r5b8" = {
        imports =
          [
            inputs.impermanence.nixosModules.home-manager.impermanence
          ]
          ++ config.mySystem.homeManagerProfiles;
        nix.settings.experimental-features = ["nix-command" "flakes"];
        home.username = "c3r5b8";
        home.homeDirectory = "/home/c3r5b8";
        home.stateVersion = "25.05";
        programs.home-manager.enable = true;
        home.packages = let
          impChanges = pkgs.writeShellScriptBin "imp_changes" ''
            set -euo pipefail
            mkdir /tmp -p
            MNTPOINT=$(mktemp -d)
            (
              sudo mount -t btrfs -o subvol=/ "/dev/root_vg/root" "$MNTPOINT"
              trap 'sudo umount "$MNTPOINT"' EXIT
              OLD_TRANSID=$(sudo btrfs subvolume find-new "$MNTPOINT/root-blank" 9999999)
              OLD_TRANSID=''${OLD_TRANSID#transid marker was }

              sudo btrfs subvolume find-new "$MNTPOINT/root" "$OLD_TRANSID" |
              sed '$d' |
              cut -f17- -d' ' |
              sort |
              uniq |
              while read -r path; do
                path="/$path"
                if [ -L "$path" ]; then
                  : # The path is a symbolic link, so is probably handled by NixOS already
                elif [ -d "$path" ]; then
                  : # The path is a directory, ignore
                else
                  echo "$path"
                fi
              done
            )
          '';
        in [
          pkgs.telegram-desktop
          pkgs.btop
          pkgs.nemo
          pkgs.jellyfin-media-player
          pkgs.pavucontrol
          pkgs.kdiskmark
          impChanges
        ];
      };
    };
  };
}
