{
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${lib.getExe pkgs.sway}";
        user = "c3r5b8";
      };
      default_session = initial_session;
    };
  };
}
