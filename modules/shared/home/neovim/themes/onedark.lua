------------------------------- THEMES: ONEDARK ------------------------------
require("onedark").setup({
  -- See options here: https://github.com/navarasu/onedark.nvim/
  transparent = true, -- Show/hide background
  style = 'deep',     -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  -- Lualine options --
  lualine = {
    transparent = true, -- lualine center bar transparency
  },
  -- Plugins Config --
  diagnostics = {
    darker = true,     -- darker colors for diagnostic
    undercurl = true,  -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },

})
-----------------------------------------------------------------------------------
