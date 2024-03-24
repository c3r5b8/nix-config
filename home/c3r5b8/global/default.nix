{
  # inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    # inputs.impermanence.nixosModules.home-manager.impermanence
    # inputs.nix-colors.homeManagerModule
    ../features/cli
    # inputs.nixvim.homeManagerModules.nixvim
    # ../features/nvim
  ];
  #  ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "c3r5b8";
    stateVersion = "23.11";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
  };
}
