{
  programs.nixvim = {
    enable = true;
    colorschemes = {
      catppuccin = {
        enable = true;
        flavour = "mocha";
        background = {
          light = "latte";
          dark = "mocha";
        };
      };
    };

    plugins = {
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          nil_ls.enable = true;
        };
      };
      treesitter = {
        enable = true;
        folding = false;
        indent = true;
      };
      treesitter-refactor = {
        enable = true;
        highlightCurrentScope.enable = true;
        highlightDefinitions.enable = true;
        smartRename.enable = true;
      };
      telescope = {
        enable = true;
        extensions = {
          file_browser = {
            enable = true;
          };
        };
      };
      todo-comments = {
        enable = true;
      };
      comment-nvim = {
        enable = true;
      };
      trouble = {
        enable = true;
      };
      fugitive = {
        enable = true;
      };
      gitgutter = {
        enable = true;
      };
      copilot-vim = {
        enable = true;
      };
      oil = {
        enable = false;
      };
    };
    options = {
      # syntax = "on";
      autoindent = true;
      clipboard = "unnamed";
      expandtab = true;
      ignorecase = true;
      mouse = "a";
      number = true;
      ruler = true;
      shiftwidth = 2;
      smartcase = true;
      tabstop = 2;
      foldenable = false;
      confirm = true;
    };
  };
}
