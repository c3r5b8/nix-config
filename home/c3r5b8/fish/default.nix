{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        function ssh
          set -lx TERM xterm-256color
          command ssh $argv
        end

      '';
      shellAbbrs = {
        gcm = "git commit -m";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";
      };
      shellAliases = {
        ll = "ls -lah";
        gs = "git status";
        gco = "git checkout";
        vim = "nvim";
        top = "btop";
        cat = "bat";
      };
    };
  };
}
