{
  description = "eander0105 nix configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } : 
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      emil = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
