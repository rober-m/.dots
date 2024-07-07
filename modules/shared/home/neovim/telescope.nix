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
            -- Docs: https://github.com/nvim-telescope/telescope.nvim#pickers
            require("which-key").register({
                                  s = {
                                    name = "search",
                                    f = { ":Telescope find_files<cr>", "File" },
                                    t = { ":Telescope live_grep<cr>", "Text" },
                                    b = { ":Telescope buffers<cr>", "Open Buffer" },
                                    m = { ":Telescope git_status<cr>", "Modified Files" },
                                  },
                                }, { prefix = "<leader>" })
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
            -- Docs - zoxide: https://github.com/ajeetdsouza/zoxide
            -- Docs - telescope-zoxide: https://github.com/jvgrootveld/telescope-zoxide
            require("which-key").register({
                                  s = {
                                    name = "search",
                                    z = { ":Telescope zoxide list<cr>", "Zoxide list" },
                                  },
                                }, { prefix = "<leader>" })
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
            -- Docs: https://github.com/nvim-telescope/telescope-file-browser.nvim
            -- This could be used as an alternative to NERDTree.
            require("telescope").load_extension "file_browser"
            require("which-key").register({
                                  ["<C-b>"] = { ":Telescope file_browser<cr>", "Browse Files" },
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
            -- Docs: https://github.com/luc-tielen/telescope_hoogle/
            require("telescope").load_extension "hoogle"
            require("which-key").register({
                                  h = {
                                    name = "Haskell",
                                    s = { ":Telescope hoogle<cr>", "Hoogle search" },
                                  },
                                }, { prefix = "<leader>" })
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
