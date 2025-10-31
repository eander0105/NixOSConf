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
}
