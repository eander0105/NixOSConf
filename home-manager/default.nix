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
    ../modules/home-manager/gnome
    ../modules/home-manager/git.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # programs.home-manager.enable = true;
  # programs.git.enable = true;

  home.stateVersion = "23.11";
}