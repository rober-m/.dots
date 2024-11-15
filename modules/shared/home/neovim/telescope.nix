{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      which-key-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            -------------------------------------- TELESCOPE ----------------------------------------
            -- DOCS: https://github.com/nvim-telescope/telescope.nvim#pickers
            require("which-key").add({
                { "<leader>s", group = "search"},
                { "<leader>sf", ":Telescope find_files<cr>", desc = "File" },
                { "<leader>sa", ":Telescope find_files hidden=true no_ignore=true no_ignore_parent=true<cr>", desc = "All Files" },
                { "<leader>st", ":Telescope live_grep<cr>", desc = "Text" },
                { "<leader>sb", ":Telescope buffers<cr>", desc = "Open Buffer" },
                { "<leader>sm", ":Telescope git_status<cr>", desc = "Modified Files" },
                { "<leader>sh", ":Telescope help_tags<cr>", desc = "Help Tags" },
            })
            -----------------------------------------------------------------------------------------
          '';
      }
      {
        plugin = telescope-zoxide;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            -------------------------------- TELESCOPE: ZOXIDE --------------------------------------
            -- Move NVIM session to a directory using Zoxide.
            -- INFO: Select with <C-f> to pipe selected folder files to Telescope's find_files.
            -- Needs to have Zoxide installed.
            -- DOCS: - zoxide: https://github.com/ajeetdsouza/zoxide
            -- DOCS: - telescope-zoxide: https://github.com/jvgrootveld/telescope-zoxide
            require("which-key").add({
                { "<leader>sz", ":Telescope zoxide list<cr>", desc = "Zoxide list" },
            })
            -----------------------------------------------------------------------------------------
          '';
      }
      {
        plugin = telescope-file-browser-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            ----------------------------- TELESCOPE: FILE BROWSER -----------------------------------
            -- DOCS: https://github.com/nvim-telescope/telescope-file-browser.nvim
            -- This could be used as an alternative to NERDTree.
            require("telescope").load_extension "file_browser"
            require("which-key").add({
                { "<leader>sB", ":Telescope file_browser<cr>", desc = "Browse Files" },
            })
            -----------------------------------------------------------------------------------------
          '';
      }
      {
        plugin = telescope_hoogle;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            --------------------------------- TELESCOPE: HOOGLE -------------------------------------
            -- DOCS: https://github.com/luc-tielen/telescope_hoogle/
            require("telescope").load_extension "hoogle"
            require("which-key").add({
                { "<leader>h", group = "haskell"},
                { "<leader>hs", ":Telescope hoogle<cr>", desc = "Hoogle search" },
            })
            -----------------------------------------------------------------------------------------
          '';
      }
    ];

    extraPackages = with pkgs; [
      zoxide
      ripgrep
      haskellPackages.hoogle
    ];
  };
}
