{
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.writeShellScript "sway-session" ''
          if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
            . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
          elif [ -e "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
            . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
          fi

          export XDG_SESSION_TYPE=wayland
          export XDG_SESSION_DESKTOP=sway
          export XDG_CURRENT_DESKTOP=sway

          exec ${lib.getExe pkgs.sway}
        ''}";
        user = "c3r5b8";
      };
      default_session = initial_session;
    };
  };
}
