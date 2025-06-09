{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting

        alias cat="bat"
      '';
      plugins = [
        {
          name = "bang-bang";
          src = pkgs.fishPlugins.bang-bang.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "forgit";
          src = pkgs.fishPlugins.forgit.src;
        }
        {
          name = "hydro";
          src = pkgs.fishPlugins.hydro.src;
        }
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge.src;
        }
      ];
    };
    bash = {
      enable = true;
      # NOTE: fix for https://github.com/nix-community/home-manager/issues/3307
      bashrcExtra = ''
        case "$(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm)" in
        "fish"|"systemd")
          ;;
        *)
          if [[ -z ''${BASH_EXECUTION_STRING} && ''${SHLVL} == 1 ]]; then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi ;;
        esac
      '';
    };
  };
}
