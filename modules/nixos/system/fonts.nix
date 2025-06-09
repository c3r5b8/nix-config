{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      material-icons
      material-design-icons
      twemoji-color-font
      inter
      dejavu_fonts
      fira
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.iosevka
      nerd-fonts.fira-code
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "FiraCode Nerd Font"
          "Iosevka Term"
          "Iosevka Term Nerd Font Complete Mono"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Fira Sans" "Noto Color Emoji"];
        serif = ["Fira Sans" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
