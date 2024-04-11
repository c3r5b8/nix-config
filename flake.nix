{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
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

    superfile = {
      url = "github:c3r5b8/superfile";
      # url = "path:/home/c3r5b8/dev/superfile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = ["x86_64-linux"];
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    inherit lib;
    formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);
    overlays = import ./overlays {inherit inputs outputs;};
    nixosConfigurations = {
      antares = lib.nixosSystem {
        modules = [
          ./hosts/antares
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.c3r5b8 = import ./home/c3r5b8/antares.nix;
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
          }
          # {
          #   environment.systemPackages = let
          #     system = "x86_64-linux";
          #   in [
          #     inputs.superfile.packages.${system}.default
          #   ];
          # }
        ];
        specialArgs = {inherit inputs outputs;};
      };
      sargas = lib.nixosSystem {
        modules = [
          ./hosts/sargas
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.c3r5b8 = import ./home/c3r5b8/sargas.nix;
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
          }
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };
  };
}
