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
      noto-fonts-color-emoji
      # nerd-fonts.iosevka
      # nerd-fonts.fira-code
      nerd-fonts.adwaita-mono
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "AdwaitaMono Nerd Font"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        # sansSerif = ["Fira Sans" "Noto Color Emoji"];
        # serif = ["Fira Sans" "Noto Color Emoji"];
        # emoji = ["Noto Color Emoji"];
      };
    };
  };
}
