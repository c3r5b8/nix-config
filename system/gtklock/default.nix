{pkgs, ...}: {
  programs.gtklock = {
    enable = true;
    package = pkgs.gtklock.overrideAttrs (old: {
      version = "4.0.0-unstable";
      src = pkgs.fetchFromGitHub {
        owner = "jovanlanik";
        repo = "gtklock";
        rev = "3ba3671";
        hash = "sha256-i7kFJQXspm+qREuuzYoQ0j2SSjHUWZ2oCP8+eTgCl3w=";
      };
    });
  };
}
