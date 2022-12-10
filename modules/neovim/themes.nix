
{ pkgs, inputs, system, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      sonokai
      dracula-vim
      gruvbox
      papercolor-theme

      { 
        plugin = tokyonight-nvim;
        type = "lua";
        config = ''
          vim.g.tokyonight_transparent = true
          vim.g.tokyonight_transparent_sidebar = true
          vim.opt.background = "dark"
          vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
          require("tokyonight").setup({
            -- See options here: https://github.com/folke/tokyonight.nvim
            -- leave it empty to use the default settings
            transparent = true, -- Enable this to disable setting the background color
          })
        '';
      }

    ];

    extraConfig = ''
      lua << EOF
      vim.cmd([[
        "set termguicolors " 24-bit colors
        colorscheme tokyonight
        " colorscheme sonokai
        " colorscheme PaperColor
      ]])
      EOF
    '';
  };
}