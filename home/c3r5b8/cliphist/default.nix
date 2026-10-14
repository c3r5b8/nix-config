{
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.cliphist.Service.ExecStart = lib.mkForce "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch ${lib.getExe pkgs.cliphist} -max-items 1000 store";
  services.cliphist = {
    enable = true;
    allowImages = false;
    extraOptions = [
      "-max-items"
      "1000"
    ];
  };
}
