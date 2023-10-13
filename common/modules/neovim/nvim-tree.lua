---------------------------------- NVIM-TREE-LUA ----------------------------------------
-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Empty setup using defaults
require("nvim-tree").setup {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    float = {
      enable = false,
    },
  },
  filters = {
    dotfiles = false,
  },
  update_focused_file = {
    enable = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
}

-- Remappings
nmap("<C-e>", ":NvimTreeToggle<cr>")
imap("<C-e>", ":NvimTreeToggle<cr>")
-----------------------------------------------------------------------------------------
