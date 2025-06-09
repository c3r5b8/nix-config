{pkgs, ...}: {
  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
    settings = {
      output_name = "2";
    };
    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Virtual Desktop";
          prep-cmd = [
            {
              do = "${pkgs.sway}/bin/swaymsg output HEADLESS-1 enable";
              undo = "${pkgs.sway}/bin/swaymsg output HEADLESS-1 disable";
            }
          ];
          exclude-global-prep-cmd = "false";
          auto-detach = "true";
        }
      ];
    };
  };
}
