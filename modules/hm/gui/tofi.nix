{pkgs, ...}: {
  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 5;
      font = "${pkgs.fira}/share/fonts/opentype/FiraSans-Regular.otf";
      text-color = "#4c4f69";
      prompt-color = "#40a02b";
      selection-color = "#209fb5";
      background-color = "#eff1f5";
    };
  };
}
