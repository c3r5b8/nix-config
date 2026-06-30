{pkgs, ...}: {
  xdg.userDirs = {
    enable = true;

    desktop = "$HOME/desktop";
    download = "$HOME/downloads";
    templates = "$HOME/templates";
    publicShare = "$HOME/public";
    documents = "$HOME/docs";
    music = "$HOME/music";
    pictures = "$HOME/pictures";
    videos = "$HOME/videos";
  };
  home.packages = with pkgs; [
    imv
    mpv
  ];

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "image/jpeg" = ["imv.desktop"];
      "image/png" = ["imv.desktop"];
      "image/gif" = ["imv.desktop"];
      "image/webp" = ["imv.desktop"];
      "image/bmp" = ["imv.desktop"];
      "image/tiff" = ["imv.desktop"];
      "image/svg+xml" = ["imv.desktop"];
      "image/x-icon" = ["imv.desktop"];

      "video/*" = ["mpv.desktop"];
      "audio/*" = ["mpv.desktop"];

      "application/pdf" = ["firefox.desktop"];
      "application/x-pdf" = ["firefox.desktop"];

      "application/zip" = ["xarchiver.desktop"];
      "application/x-tar" = ["xarchiver.desktop"];
      "application/gzip" = ["xarchiver.desktop"];
      "application/x-bzip2" = ["xarchiver.desktop"];
      "application/x-7z-compressed" = ["xarchiver.desktop"];
      "application/x-rar-compressed" = ["xarchiver.desktop"];

      "inode/directory" = ["thunar.desktop"];
      "x-scheme-handler/file" = ["thunar.desktop"];
    };
  };
  xdg.configFile."gtk-3.0/bookmarks".text = ''
    sftp://c3r5b8@sargas/ sargas
    sftp://c3r5b8@antares/ antares
    sftp://c3r5b8@shaula/ shaula
    sftp://c3r5b8@acrab/ acrab
  '';
}
