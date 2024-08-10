{pkgs, ...}: let
  copilot-lualine = pkgs.vimUtils.buildVimPlugin {
    name = "copilot-lualine";
    src = pkgs.fetchFromGitHub {
      owner = "AndreM222";
      repo = "copilot-lualine";
      rev = "4cca52f4d4d6c7439c51227d8054e346ef5ff0e0";
      hash = "sha256-zxSiSccuQE62hNZZgL4kn0G3OF5m4eA9lX4v+tGh5+U=";
    };
  };
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      copilot-lualine
      {
        plugin = lualine-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            ------------------------------------- LUALINE -------------------------------------------
            require('lualine').setup {
             -- options = {
             --   theme = 'tokyonight'
             -- }
             sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {{'copilot', show_colors = true}, 'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
             }
            }
            -----------------------------------------------------------------------------------------
          '';
      }
    ];

    extraPackages = with pkgs; [
      vimPlugins.nvim-web-devicons
    ];
  };
}
