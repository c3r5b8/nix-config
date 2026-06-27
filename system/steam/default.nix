{pkgs, ...}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  networking.hosts = {
    "0.0.0.0" = [
      "paradise-s1.battleye.com"
      "test-s1.battleye.com"
      "paradiseenhanced-s1.battleye.com"
    ];
  };
}
