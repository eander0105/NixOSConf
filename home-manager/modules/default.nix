# Home Manager modules
{
  git = import ./git.nix;
  tmux = import ./tmux.nix;
  nvim = import ./nvim.nix;
  obsidian = import ./obsidian.nix;
  gnome = import ./gnome;
  java = import ./dev/java.nix;
}
