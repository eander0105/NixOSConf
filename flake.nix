{
  description = "eander0105 nix configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-utils,
    home-manager,
    ...
  }@inputs :
  let
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    lib = nixpkgs.lib;
  in rec {
    legacyPackages = forAllSystems (system:
      import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      }
    );

    nixosConfigurations = {
      lillagron = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/lillagron ];
      };
    };
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
