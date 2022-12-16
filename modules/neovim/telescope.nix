
{ pkgs, inputs, system, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          -------------------------------------- TELESCOPE ----------------------------------------
          -- Docs: https://github.com/nvim-telescope/telescope.nvim#pickers
          nmap("<leader>ff", ":Telescope find_files<cr>") -- Lists files in your current working directory, respects .gitignore
          nmap("<leader>fg", ":Telescope live_grep<cr>")
          nmap("<leader>fb", ":Telescope buffers<cr>")    -- Lists open buffers in current neovim instance
          nmap("<leader>fh", ":Telescope help_tags<cr>")
          ----------------------------------------------------------------------------------------- 
        '';
      }
      {
        plugin = telescope-zoxide;
        type = "lua";
        config = ''
          -------------------------------- TELESCOPE-ZOXIDE ---------------------------------------
          -- zoxide: https://github.com/ajeetdsouza/zoxide
          -- telescope-zoxide: https://github.com/jvgrootveld/telescope-zoxide
          -- Needs to have Zoxide installed.
          nmap("<leader>fz", ":Telescope zoxide list<cr>")
          ----------------------------------------------------------------------------------------- 
        '';
      }
      {
        plugin = telescope-file-browser-nvim;
        type = "lua";
        config = ''
          ------------------------------ TELESCOPE FILE BROWSER ----------------------------------
          -- You don't need to set any of these options.
          -- IMPORTANT!: this is only a showcase of how you can set default options!
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
          nmap("<leader>fb", ":Telescope file_browser path=%:p:h<cr>")
          nmap("<leader>fB", ":Telescope file_browser<cr>")
          ----------------------------------------------------------------------------------------- 
        '';
      }

    ];
  };
}