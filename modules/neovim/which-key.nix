{ pkgs, inputs, system, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''

          ------------------------------------- WHICH-KEY -----------------------------------------
          require("which-key").setup {

            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          }
          require("which-key").register({
            ["gh"] = { "0", "GoTo beginning of line"},
            ["gl"] = { "$", "GoTo end of line"},
          })
          -----------------------------------------------------------------------------------------
        '';
      }

    ];
  };
}
