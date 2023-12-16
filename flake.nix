{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in {
      inherit lib;
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);
      nixosConfigurations = {
        antares = lib.nixosSystem {
          modules = [
            ./hosts/antares
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.c3r5b8 = import ./home/c3r5b8/antares.nix;
            }
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # homeConfigurations = {
      #   "c3r5b8@antares" = lib.homeManagerConfiguration {
      #     modules = [ ./home/c3r5b8/antares.nix ];
      #     pkgs = pkgsFor.x86_64-linux;
      #     extraSpecialArgs = { inherit inputs outputs; };
      #   };
      # };
    };
}
