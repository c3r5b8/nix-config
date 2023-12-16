{
  inputs,
  pkgs,
  ...
  # }: let
  #   marketplace-extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
  #     # johnnymorganz.stylua
  #     ms-python.black-formatter
  #     ms-python.python
  #     platformio.platformio-ide
  #     # rvest.vs-code-prettier-eslint
  #     # sndst00m.markdown-github-dark-pack
  #     rangav.vscode-thunder-client
  #     mathiasfrohlich.kotlin
  #     jebbs.plantuml
  #   ];
  # in {
}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      # jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      # dbaeumer.vscode-eslint
      eamodio.gitlens
      # esbenp.prettier-vscode
      github.copilot
      github.copilot-chat
      # humao.rest-client
      golang.go
      # ms-python.python
      ms-python.vscode-pylance
      ms-pyright.pyright
      kamadorueda.alejandra
      # mkhl.direnv
      ms-python.vscode-pylance
      ms-vscode.cpptools
      naumovs.color-highlight
      # oderwat.indent-rainbow
      # pkief.material-product-icons
      # pkief.material-icon-theme
      # oderwat.indent-rainbow
      # sumneko.lua
      # usernamehw.errorlens
      # vadimcn.vscode-lldb
      # xaver.clang-format

    ];

    userSettings = {
      breadcrumbs.enabled = false;
      emmet.useInlineCompletions = true;
      catppuccin.accentColor = "green";
      go.lintTool = "golangci-lint";
      go.lintFlags = ["--fast"];
      github.copilot.enable."*" = true;
      # security.workspace.trust.enabled = false;
      # black-formatter.path = lib.changeMe pkgs.black;
      # stylua.styluaPath = lib.changeMe pkgs.stylua;
      nix.enableLanguageServer = true;
      nix.serverPath = "${pkgs.nixd}/bin/nixd";
      # Lua.misc.executablePath = "${pkgs.sumneko-lua-language-server}/bin/lua-language-server";

      # "[c]".editor.defaultFormatter = "xaver.clang-format";
      # "[cpp]".editor.defaultFormatter = "xaver.clang-format";
      # "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
      # "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
      # "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      # "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      # "[jsonc]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      # "[lua]".editor.defaultFormatter = "johnnymorganz.stylua";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
      "[go]".editor.defaultFormatter = "golang.go";
      # "[rust]".editor.defaultFormatter = "rust-lang.rust-analyzer";
      # "[scss]".editor.defaultFormatter = "sibiraj-s.vscode-scss-formatter";
      # "[typescript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      # "[python]".editor = {
      #   defaultFormatter = "ms-python.black-formatter";
      #   formatOnType = true;
      # };
      editor = {
        cursorBlinking = "smooth";
        cursorSmoothCaretAnimation = "on";
        cursorWidth = 2;
        find.addExtraSpaceOnTop = false;
        fontFamily = "'FiraCode Nerd Font', 'monospace', monospace";
        fontSize = 16;
        formatOnSave = true;
        inlayHints.enabled = "off";
        inlineSuggest.enabled = true;
        largeFileOptimizations = false;
        lineNumbers = "on";
        linkedEditing = true;
        maxTokenizationLineLength = 60000;
        minimap.enabled = false;
        overviewRulerBorder = false;
        quickSuggestions.strings = true;
        renderWhitespace = "none";
        renderLineHighlight = "all";
        smoothScrolling = true;
        suggest.showStatusBar = true;
        suggestSelection = "first";

        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };

        guides = {
          bracketPairs = true;
          indentation = true;
        };
      };

      explorer = {
        confirmDragAndDrop = false;
        confirmDelete = false;
      };

      files = {
        eol = "\n";
        insertFinalNewline = true;
        trimTrailingWhitespace = true;
        autoSave = "afterDelay";
      };

      git = {
        autofetch = true;
        confirmSync = false;
        enableSmartCommit = true;
      };

      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "line";
        cursorWidth = 2;
        fontFamily = "'monospace'";
        fontSize = 16;
        smoothScrolling = true;
      };

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = false;
      };
      workbench = {
        colorTheme = "Catppuccin Mocha";
        editor = {
          tabCloseButton = "right";
          tabActionLocation = "right";
        };
        list.smoothScrolling = true;
        panel.defaultLocation = "right";
        smoothScrolling = true;
      };
      workbench.iconTheme = "catppuccin-mocha";
      # workbench.editor.tabActionLocation = "right";
    };
  };
  home.packages = with pkgs; [
    gopls
    delve
    go-tools
    go
    sqlc
    goose
    clang-tools
    nodejs
    gcc
    php
    python3
    gnumake
    platformio
    delve
    alejandra
    nodePackages.typescript
    typescript
  ];
}
