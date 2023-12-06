{
  description = "eander0105 nix configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/23.11";
  };

  outputs = { self, nixpkgs, ... } : 
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      emil = {
        system = "x86_64-linux";
        modules = [ "./configuration.nix" ];
      };
    };
  };
}
