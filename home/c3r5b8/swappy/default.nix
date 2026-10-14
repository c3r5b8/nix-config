{config, ...}: {
  programs.swappy = {
    enable = true;
    settings.Default = {
      save_dir = "${config.xdg.userDirs.pictures}";
      save_filename_format = "screenshot-%s.png";
      early_exit = true;
    };
  };
}
