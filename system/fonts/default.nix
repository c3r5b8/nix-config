{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira
      nerd-fonts.fira-code
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Fira Sans"];
        sansSerif = ["Fira Sans"];
        monospace = ["FiraCode Nerd Font"];
      };
    };
  };
}
