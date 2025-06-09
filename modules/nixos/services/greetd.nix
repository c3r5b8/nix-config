{pkgs, ...}: {
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.sway}/bin/sway";
          user = "c3r5b8";
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --asterisks --cmd sway";
          # user = "greeter";
        };
      };
    };
  };
}
