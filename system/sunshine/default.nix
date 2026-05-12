{
  pkgs,
  lib,
  config,
  ...
}: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
    settings = {
      locale = "en";
      sunshine_name = "${config.networking.hostName}";
      system_tray = "disabled";
      controller = "disabled";
      keyboard = "disabled";
      mouse = "disabled";
      stream_audio = "disabled";
      output_name = 1;
      capture = "wlr";
    };
    applications.apps = [
      {
        name = "Virual Desktop";
        prep-cmd = [
          {
            do = "${lib.getExe' pkgs.sway "swaymsg"} output HEADLESS-1 enable";
            undo = "${lib.getExe' pkgs.sway "swaymsg"} output HEADLESS-1 disable";
          }
        ];
        exclude-global-prep-cmd = "false";
        auto-detach = "true";
      }
    ];
  };
}
