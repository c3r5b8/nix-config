{
  pkgs,
  lib,
  ...
}: {
  xdg.portal.wlr = {
    enable = true;
    settings = {
      screencast = {
        max_fps = 60;
        chooser_type = "dmenu";
        chooser_cmd = "${lib.getExe pkgs.fuzzel} -d -l 12 -p 'Select a source to share:'";
      };
    };
  };
}
