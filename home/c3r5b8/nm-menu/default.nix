{
  pkgs,
  lib,
  ...
}: let
  nm-menu = pkgs.symlinkJoin {
    name = "nm-menu";
    paths = [(pkgs.writeShellScriptBin "nm-menu" (builtins.readFile ./nm-menu))];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nm-menu \
        --prefix PATH : ${lib.makeBinPath (with pkgs; [
        fuzzel
        networkmanager
        gawk
        coreutils
        gnugrep
        wl-clipboard
      ])}

      mkdir -p $out/share/applications
      cat > $out/share/applications/nm-menu.desktop <<'EOF'
      [Desktop Entry]
      Type=Application
      Version=1.0
      Name=Networks
      GenericName=Network menu
      Comment=Connect and disconnect NetworkManager profiles
      Exec=nm-menu
      Icon=network-wireless
      Terminal=false
      Categories=Network;
      Keywords=nmcli;vpn;wifi;dummy;
      EOF
    '';
  };
in {
  home.packages = [nm-menu];
}
