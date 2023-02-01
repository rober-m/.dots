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

          local normal_pane_movements = {
              ["∆"] = { "<C-w>j", "Move to pane below"},
              ["˚"] = { "<C-w>k", "Move to pane above"},
              ["˙"] = { "<C-w>h", "Move to left pane"},
              ["¬"] = { "<C-w>l", "Move to right pane"},
          }

          local terminal_pane_movements = {
              ["∆"] = { "<C-\\><C-N><C-w>j", "Move to pane below"},
              ["˚"] = { "<C-\\><C-N><C-w>k", "Move to pane above"},
              ["˙"] = { "<C-\\><C-N><C-w>h", "Move to left pane"},
              ["¬"] = { "<C-\\><C-N><C-w>l", "Move to right pane"},
          }

          require("which-key").register(normal_pane_movements, { mode = 'n', silent = true })
          require("which-key").register(terminal_pane_movements, { mode = 't', silent = true })
          -----------------------------------------------------------------------------------------
        '';
      }

    ];
  };
}
