{ pkgs, config, inputs, ... }:
{
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = path: "lua << EOF\n${builtins.readFile path}\nEOF\n";
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    # lsp.options = toluaFile ./lsp.lua;
  };
}
