{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./modules/gnome
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/nvim.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
