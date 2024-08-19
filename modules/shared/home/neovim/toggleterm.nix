{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''

            ------------------------------------ TOGGLETERM -----------------------------------------
            -- DOCS: https://github.com/akinsho/toggleterm.nvim/
            require("toggleterm").setup {
              open_mapping = [[<c-\>]],
            }
            -----------------------------------------------------------------------------------------
          '';
      }
    ];
  };
}
