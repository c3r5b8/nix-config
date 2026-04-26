{pkgs, ...}: {
  imports = [
    ../../home/c3r5b8
  ];
  home.packages = with pkgs; [
    nvtopPackages.intel
  ];
}
