{pkgs, ...}: {
  programs.gtklock = {
    enable = true;
    modules = with pkgs; [
      gtklock-virtkb-module
    ];
  };
}
