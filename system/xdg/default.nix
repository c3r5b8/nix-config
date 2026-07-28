{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (old: {
        src = final.fetchFromGitHub {
          owner = "funk443";
          repo = "xdg-desktop-portal-wlr";
          rev = "74be7063347880f6bf98689e24dd9a6e98032405";
          sha256 = "125rsvls0gyc7a0lspvrqm54ckplfvd18q963yfmq47d6n3im6gr";
        };
      });
    })
  ];
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
