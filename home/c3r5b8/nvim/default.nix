{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    tree-sitter
    libgcc
    rustc
    cargo
    gopls
    lua-language-server
    markdownlint-cli
    stylua
    gnumake
    sops
    nixd
    alejandra
    go
    ripgrep
  ];

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
