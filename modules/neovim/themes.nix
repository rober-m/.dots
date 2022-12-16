
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
          ------------------------------- THEMES: TOKYO NIGHT ------------------------------
          vim.g.tokyonight_transparent = true
          vim.g.tokyonight_transparent_sidebar = true
          vim.opt.background = "dark"
          vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
          require("tokyonight").setup({
            -- See options here: https://github.com/folke/tokyonight.nvim
            -- leave it empty to use the default settings
            transparent = true, -- Enable this to disable setting the background color
          })
          -----------------------------------------------------------------------------------
        '';
      }

    ];

    extraConfig = ''
    lua << EOF
    ------------------------------- THEMES EXTRA CONFIG ------------------------------
    vim.cmd([[
      colorscheme tokyonight
    ]])
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -----------------------------------------------------------------------------------
    EOF
    '';
  };
}