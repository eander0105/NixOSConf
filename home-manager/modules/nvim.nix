{ pkgs, config, inputs, ... }:
{

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    extraPackages = with pkgs; [
      ripgrep   # needed for :Telescope live_grep
      fd        # speeds up :Telescope find_files
    ];
  };

  # TODO: If posible make path not absolute
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/emil/nix-conf/dotfiles/nvim";
    };
  };
}
