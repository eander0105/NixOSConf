{
  description = "eander0105 nix configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs :
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations.emil = lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
