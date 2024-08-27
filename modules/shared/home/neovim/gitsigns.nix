{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Buffer tabs
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''
              ---------------------------------------- LEAP -------------------------------------------
            -- DOCS: https://github.com/lewis6991/gitsigns.nvim
            require('gitsigns').setup()
            require("which-key").add({
              { "<leader>g",  group = "git" },
              { "<leader>gj", "<cmd>lua require('gitsigns').nav_hunk('next')<CR>", desc = "Next Git Hunk", },
              { "<leader>gk", "<cmd>lua require('gitsigns').nav_hunk('prev')<CR>", desc = "Prev Git Hunk", },
            })
              -----------------------------------------------------------------------------------------
          '';
      }
    ];
  };
}
