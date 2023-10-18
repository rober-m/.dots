{
  pkgs,
  config,
  inputs,
  ...
}: let
  nix-colors-lib = inputs.nix-colors.lib.contrib {inherit pkgs;};
in {
  programs.neovim = {
    plugins = [
      {
        plugin = nix-colors-lib.vimThemeFromScheme {scheme = config.colorScheme;};
        config = "colorscheme nix-${config.colorScheme.slug}";
      }
      #   sonokai
      #   dracula-nvim
      #   gruvbox
      #   papercolor-theme
      #
      #   {
      #     plugin = catppuccin-nvim; # colorscheme catppuccin-latte / catppuccin-frappe / catppuccin-macchiato / catppuccin-mocha
      #     type = "lua";
      #     config = ''
      #       ------------------------------- THEMES: CATPPUCCIN --------------------------------
      #       require("catppuccin").setup({tokyonight
      #         flavour = "latte", -- latte, frappe, macchiato, mocha
      #         background = { -- :h background
      #             light = "latte",
      #             dark = "mocha",
      #         },
      #         transparent_background = true, -- disables setting the background color.
      #         show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      #         term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      #         dim_inactive = {
      #             enabled = false, -- dims the background color of inactive window
      #             shade = "dark",
      #             percentage = 0.15, -- percentage of the shade to apply to the inactive window
      #         },
      #       })
      #       -----------------------------------------------------------------------------------
      #     '';
      #   }
      #   {
      #     plugin = tokyonight-nvim; # colorscheme tokyonight
      #     type = "lua";
      #     config = ''
      #       ------------------------------- THEMES: TOKYO NIGHT ------------------------------
      #       vim.g.tokyonight_transparent = true
      #       vim.g.tokyonight_transparent_sidebar = true
      #       require("tokyonight").setup({
      #         -- See options here: https://github.com/folke/tokyonight.nvim
      #         -- transparent = true, -- Enable this to disable setting the background color
      #       })
      #       -----------------------------------------------------------------------------------
      #     '';
      #   }
      #
      #   {
      #     plugin = onedark-nvim;
      #     type = "lua";
      #     config = ''
      #       ------------------------------- THEMES: ONEDARK ------------------------------
      #       require("onedark").setup({
      #         -- See options here: https://github.com/navarasu/onedark.nvim/
      #         transparent = true, -- Show/hide background
      #         style = 'deep', -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      #         -- Lualine options --
      #         lualine = {
      #             transparent = true, -- lualine center bar transparency
      #         },
      #         -- Plugins Config --
      #         diagnostics = {
      #             darker = true, -- darker colors for diagnostic
      #             undercurl = true,   -- use undercurl instead of underline for diagnostics
      #             background = true,    -- use background color for virtual text
      #         },
      #
      #       })
      #       -----------------------------------------------------------------------------------
      #     '';
      #   }
    ];

    extraConfig = ''
      lua << EOF
      ------------------------------- THEMES EXTRA CONFIG ------------------------------
      --vim.opt.background = "dark" -- Values are "dark" or "light" to indicate the mode.
      --vim.cmd([[
      --  " colorscheme tokyonight
      --  " colorscheme catppuccin-macchiato
      --  colorscheme gruvbox
      --  " colorscheme dracula
      --  " colorscheme onedark
      --]])

      -- Next block: Remove all background colors so it looks transparent
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" }) -- Remove NvimTree background
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" }) -- Remove left gutter background
      -----------------------------------------------------------------------------------
      EOF
    '';
  };
}
