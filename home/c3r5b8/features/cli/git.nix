{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    # package = pkgs.gitAndTools.gitFull;
    # aliases = {
    #   ff = "merge --ff-only";
    #   pushall = "!git remote | xargs -L1 git push --all";
    #   graph = "log --decorate --oneline --graph";
    #   add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
    #   fast-forward = "merge --ff-only";
    # };
    userName = "c3r5b8";
    userEmail = "olespid@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      # user.signing.key = "CE707A2C17FAAC97907FF8EF2E54EA7BFE630916";
      # commit.gpgSign = true;
      # gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    # lfs.enable = true;
    # ignores = [ ".direnv" "result" ];
  };
}
