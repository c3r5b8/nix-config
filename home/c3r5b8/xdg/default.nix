{
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
  xdg.configFile."gtk-3.0/bookmarks".text = ''
    sftp://c3r5b8@sargas/ sargas
    sftp://c3r5b8@antares/ antares
    sftp://c3r5b8@shaula/ shaula
    sftp://c3r5b8@acrab/ acrab
  '';
}
