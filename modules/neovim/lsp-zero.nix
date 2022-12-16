{ pkgs, inputs, system, ... }:

{
   programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        # WARNING!!: lsp-zero isn't in Nix pkgs yet :(
        plugin = lsp-zero;
        type = "lua";
        config = ''
          local lsp = require('lsp-zero')
          lsp.preset('recommended')
          lsp.setup()
        '';
      }

    ];

  };

}