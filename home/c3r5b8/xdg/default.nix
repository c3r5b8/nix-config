{
  xdg.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "$HOME/desktop";
    documents = "$HOME/documents";
    download = "$HOME/downloads";
    music = "$HOME/music";
    pictures = "$HOME/pictures";
    publicShare = "$HOME/public";
    templates = "$HOME/templates";
    videos = "$HOME/videos";
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/plain" = ["org.gnome.TextEditor.desktop"];
      "video/*" = ["org.gnome.Showtime.desktop"];
      "audio/*" = ["org.gnome.Decibels.desktop"];
      "image/*" = ["org.gnome.Loupe.desktop"];
      "application/pdf" = ["org.gnome.Papers.desktop"];
      "application/postscript" = ["org.gnome.Papers.desktop"];
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };
  };
}
