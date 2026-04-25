# NixOS modules
{
  base = import ./base.nix;
  docker = import ./docker.nix;
  gnome = import ./UI/gnome.nix;
  audio = import ./hardware/audio.nix;
  graphics = import ./hardware/graphics.nix;
  network = import ./hardware/network.nix;
}
