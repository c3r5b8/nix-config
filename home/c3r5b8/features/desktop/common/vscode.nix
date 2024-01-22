{
  inputs,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      eamodio.gitlens
      github.copilot
      github.copilot-chat
      golang.go
      ms-python.vscode-pylance
      ms-pyright.pyright
      kamadorueda.alejandra
      ms-python.vscode-pylance
      ms-vscode.cpptools
      naumovs.color-highlight
    ];
    userSettings = {
      breadcrumbs.enabled = false;
      emmet.useInlineCompletions = true;
      catppuccin.accentColor = "green";
      go.lintTool = "golangci-lint";
      go.lintFlags = ["--fast"];
      github.copilot.enable."*" = true;
      nix.enableLanguageServer = true;
      nix.serverPath = "${pkgs.nixd}/bin/nixd";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
      "[go]".editor.defaultFormatter = "golang.go";
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
      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "line";
        cursorWidth = 2;
        fontFamily = "'monospace'";
        fontSize = 16;
        smoothScrolling = true;
      };
      window = {
        titleBarStyle = "custom";
        nativeTabs = false;
      };
      workbench = {
        colorTheme = "Catppuccin Mocha";
        list.smoothScrolling = true;
        panel.defaultLocation = "right";
        smoothScrolling = true;
      };
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
