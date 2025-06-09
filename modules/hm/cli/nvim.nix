{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    # gitFull
    gcc
    tree-sitter
    libgcc
    rustc
    cargo
    gopls
    lua-language-server
    stylua
    gnumake
    nixd
    alejandra
    go
    ripgrep
  ];
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/persist/home/dev/nix-config/nvim";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.desktopEntries.nvim = {
    name = "Neovim";
    comment = "Edit text files";

    exec = "kitty -e nvim %F";

    terminal = true;

    icon = "nvim";
    type = "Application";
    categories = ["Utility" "TextEditor"];
  };

  home.persistence."/persist/nvim" = {
    allowOther = true;
    directories = [
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };
}
