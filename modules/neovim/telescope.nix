{ pkgs, inputs, system, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      which-key-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          -------------------------------------- TELESCOPE ----------------------------------------
          -- Docs: https://github.com/nvim-telescope/telescope.nvim#pickers
          require("which-key").register({
                                s = {
                                  name = "search",
                                  f = { ":Telescope find_files<cr>", "File" }, 
                                  s = { ":Telescope live_grep<cr>", "String" }, 
                                  b = { ":Telescope buffers<cr>", "Open Buffer" }, 
                                },
                              }, { prefix = "<leader>" })
          ----------------------------------------------------------------------------------------- 
        '';
      }
      {
        plugin = telescope-zoxide;
        type = "lua";
        config = ''
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
        config = ''
          ------------------------------ TELESCOPE: FILE BROWSER ----------------------------------
          Docs: https://github.com/nvim-telescope/telescope-file-browser.nvim
          -- There's a lot of options. It's like nvim-tree but inside telescope
          require("telescope").setup {
            extensions = {
              file_browser = {
                theme = "ivy",
                mappings = {
                  ["i"] = {
                    -- your custom insert mode mappings
                  },
                  ["n"] = {
                    -- your custom normal mode mappings
                  },
                },
              },
            },
          }
          -- To get telescope-file-browser loaded and working with telescope,
          -- you need to call load_extension, somewhere after setup function:
          require("telescope").load_extension "file_browser"
          require("which-key").register({
                                s = {
                                  name = "search",
                                  B = { ":Telescope file_browser<cr>", "Browser" }, 
                                },
                              }, { prefix = "<leader>" })
          ----------------------------------------------------------------------------------------- 
        '';
      }

    ];

    extraPackages = with pkgs; [
      zoxide
      ripgrep
    ];

  };
}

