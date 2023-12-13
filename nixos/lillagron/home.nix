{ inputs, outputs, lib, config, ... }:

{
  config = {
    home-manager = {
      extraSpecialArgs = { inherit inputs outputs; };
      users = {
        emil = import ../../home-manager;
      };
    };

  };
}
