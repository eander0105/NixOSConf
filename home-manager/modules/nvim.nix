{ pkgs, config, inputs, ... }:
{

  # Neovim is installed as a plain package so home-manager does not generate
  # its own init.lua. The actual config is managed out-of-store via the symlink
  # below, pointing at dotfiles/nvim (a self-contained lazy.nvim setup).
  home.packages = with pkgs; [
    neovim
    ripgrep   # needed for :Telescope live_grep
    fd        # speeds up :Telescope find_files
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    vimdiff = "nvim -d";
  };

  # TODO: If posible make path not absolute
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/emil/nix-conf/dotfiles/nvim";
    };
  };
}
