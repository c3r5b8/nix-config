{pkgs, ...}: let
  mkCatppuccinPapirus = {
    flavor,
    accent ? "green",
  }:
    (pkgs.catppuccin-papirus-folders.override {inherit flavor accent;}).overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "c3r5b8";
        repo = "papirus-folders";
        rev = "5d4e00367e93390e5375b88b6d33b501fff0efc4";
        sha256 = "sha256-EBqpud/z2On70ny1MFHknRHGqrnRwb+9t3I1dpUY5So=";
      };
      pname = "catppuccin-papirus-folders-${flavor}";

      # Run after the original installPhase
      postInstall = ''
        for dir in $out/share/icons/Papirus*; do
          if [ -d "$dir" ]; then
            oldName=$(basename "$dir")
            # Example naming: Papirus → Papirus-Catppuccin-Mocha
            #                 Papirus-Dark → Papirus-Dark-Catppuccin-Mocha
            newName="''${oldName}-Catppuccin-${flavor}"
            mv "$dir" "$out/share/icons/$newName"

            # Update the visible name inside index.theme
            if [ -f "$out/share/icons/$newName/index.theme" ]; then
              sed -i "s|^Name=.*|Name=$newName|" "$out/share/icons/$newName/index.theme"
            fi
          fi
        done
      '';
    });
in {
  home.packages = [
    pkgs.bibata-cursors
    (mkCatppuccinPapirus {flavor = "mocha";})
    (mkCatppuccinPapirus {flavor = "latte";})
    (pkgs.catppuccin-gtk.override
      {
        accents = ["green"];
        variant = "latte";
      })
    (pkgs.catppuccin-gtk.override
      {
        accents = ["green"];
        variant = "mocha";
      })
  ];
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };
}
