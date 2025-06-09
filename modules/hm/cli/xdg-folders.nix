{
  config,
  pkgs,
  ...
}: let
  browser = ["firefox"];
  pdfViewer = ["firefox"];
  officeWriter = ["libreoffice-writer"];
  officeCalc = ["libreoffice-calc"];
  officeImpress = ["libreoffice-impress"];
  imageViewer = ["imv"];
  videoPlayer = ["mpv"];
  audioPlayer = ["mpv"];
  fileManager = ["nemo"];
  textEditor = ["nvim"];
  mailClient = ["userapp-Thunderbird-JJ6S42"];

  xdgAssociations = type: program: list:
    builtins.listToAttrs (map (e: {
        name = "${type}/${e}";
        value = program;
      })
      list);

  associations =
    # Mail
    (xdgAssociations "x-scheme-handler" mailClient ["mailto" "mid"])
    // (xdgAssociations "message" mailClient ["rfc822"])
    # File Manager
    // (xdgAssociations "x-scheme-handler" fileManager ["ftp"])
    // {"inode/directory" = fileManager;}
    # Browser
    // {"text/html" = browser;}
    // (xdgAssociations "x-scheme-handler" browser ["http" "https"])
    # PDF
    // {"application/pdf" = pdfViewer;}
    # Office Documents (OpenXML)
    // {"application/vnd.openxmlformats-officedocument.wordprocessingml.document" = officeWriter;}
    // {"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = officeCalc;}
    // {"application/vnd.openxmlformats-officedocument.presentationml.presentation" = officeImpress;}
    # Images
    // (xdgAssociations "image" imageViewer ["jpeg" "png" "gif" "svg+xml" "webp"])
    # Video
    // (xdgAssociations "video" videoPlayer ["mp4" "x-matroska" "x-msvideo"])
    # Audio
    // (xdgAssociations "audio" audioPlayer ["mpeg" "flac" "x-wav" "ogg"])
    # Text/Code files
    // {"text/plain" = textEditor;}
    // {"text/markdown" = textEditor;}
    // {"text/x-shellscript" = textEditor;}
    // {"text/x-python" = textEditor;}
    // {"text/x-csrc" = textEditor;}
    // {"text/x-go" = textEditor;};
in {
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    cacheHome = config.home.homeDirectory + "/.local/cache";
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/docs";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/pub";
      templates = "${config.home.homeDirectory}/temp";
      videos = "${config.home.homeDirectory}/videos";
      createDirectories = true;
      extraConfig = {
        XDG_DEV_DIR = "${config.home.homeDirectory}/dev";
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
        XDG_WALLPAPERS_DIR = "${config.xdg.userDirs.pictures}/wallpapers";
      };
    };
  };
  xdg.configFile."mimeapps.list".force = true;
  home.packages = [
    # used by `gio open` and xdp-gtk
    (pkgs.writeShellScriptBin "xdg-terminal-exec" ''
      ${pkgs.kitty}/bin/kitty "$@"
    '')
    pkgs.xdg-utils
  ];
}
