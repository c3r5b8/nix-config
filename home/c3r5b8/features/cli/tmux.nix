{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    newSession = true;
    prefix = "C-space";
    secureSocket = false;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];
  };
}
