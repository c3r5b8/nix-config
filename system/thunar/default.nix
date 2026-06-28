{pkgs, ...}: {
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];
  environment.systemPackages = [pkgs.engrampa];
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
