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
            -- zoxide: https://github.com/ajeetdsouza/zoxide
            -- telescope-zoxide: https://github.com/jvgrootveld/telescope-zoxide
            -- Needs to have Zoxide installed.
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
