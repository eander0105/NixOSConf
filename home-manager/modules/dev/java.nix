{ pkgs, ... }:

{
  programs.java = {
    enable = true;
  };
  home.packages = with pkgs; [
    jdk
    maven
  ];
}