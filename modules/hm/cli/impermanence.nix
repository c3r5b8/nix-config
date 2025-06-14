{
  home.persistence."/persist/home" = {
    directories = [
      "desktop"
      "docs"
      "downloads"
      "music"
      "pictures"
      "pub"
      "temp"
      "videos"
      "dev"
      ".ssh"
      ".config/sops/age"
      ".local/share/Steam"
      ".mozilla/firefox/imd3djta.default"
      ".local/share/TelegramDesktop/tdata"
      ".local/share/fish"
      ".config/sunshine"
      ".config/unity3d"
      ".factorio"
    ];
    files = [
      ".mozilla/firefox/profiles.ini"
      ".local/state/tofi-drun-history"
    ];
    allowOther = true;
  };
}
