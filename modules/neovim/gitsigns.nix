{ pkgs, inputs, system, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Buffer tabs
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          ---------------------------------------- LEAP -------------------------------------------
          -- Docs: https://github.com/lewis6991/gitsigns.nvim
          require('gitsigns').setup()
          ----------------------------------------------------------------------------------------- 
        '';
      }
    ];

  };
}
