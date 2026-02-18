{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "c3r5b8";
      };
      default_session = initial_session;
    };
  };
}
