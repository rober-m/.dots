{ pkgs, inputs, system, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      sonokai
      dracula-nvim
      gruvbox
      papercolor-theme

      # TODO: The only themes that correctly works with transparent BG is gruvbox and papercolor

      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = ''
          ------------------------------- THEMES: TOKYO NIGHT ------------------------------
          vim.g.tokyonight_transparent = true
          vim.g.tokyonight_transparent_sidebar = true
          require("tokyonight").setup({
            -- See options here: https://github.com/folke/tokyonight.nvim
            transparent = true, -- Enable this to disable setting the background color
          })
          -----------------------------------------------------------------------------------
        '';
      }

      {
        plugin = onedark-nvim;
        type = "lua";
        config = ''
          ------------------------------- THEMES: ONEDARK ------------------------------
          require("onedark").setup({
            -- See options here: https://github.com/navarasu/onedark.nvim/
            transparent = true, -- Show/hide background
            style = 'deep', -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            -- Lualine options --
            lualine = {
                transparent = false, -- lualine center bar transparency
            },
            -- Plugins Config --
            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true,   -- use undercurl instead of underline for diagnostics
                background = true,    -- use background color for virtual text
            },

          })
          -----------------------------------------------------------------------------------
        '';
      }

    ];

    extraConfig = ''
      lua << EOF
      ------------------------------- THEMES EXTRA CONFIG ------------------------------
      vim.opt.background = "dark" -- Values are "dark" or "light" to indicate the mode.
      vim.cmd([[
        colorscheme onedark
      ]])
      -- vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      -----------------------------------------------------------------------------------
      EOF
    '';
  };
}
