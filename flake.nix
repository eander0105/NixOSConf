{
  description = "eander0105 nix configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    nixos-hardware,
    flake-utils,
    home-manager,
    ...
  } @inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      lib = nixpkgs.lib;
    in rec {
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations =
        let
          specialArgs = { inherit inputs outputs; };
        in{
          lillagron = lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [ ./nixos/lillagron ];
          };
        };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    };
}
