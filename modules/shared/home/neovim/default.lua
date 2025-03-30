--------------------------------------------------------------------------------------------------
--------------------------------------  General Config -------------------------------------------

vim.g.mapleader = " "      -- Leader key
vim.g.maplocalleader = "," -- Local leader key

-- Visual
vim.opt.wrap = false                        -- Wrap text?
vim.opt.cursorline = true                   -- Highlight cursor line
vim.opt.scrolloff = 15                      -- Screen lines above and below cursor
vim.opt.list = false                        -- List mode: Show invisible chararcters
vim.opt.listchars =
"eol:¬,tab:>·,extends:>,precedes:<,space:·" -- Specify how to show invisible chars (`list = true` needed)

-- Numbers
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Use relative line numbers

-- Tabs
vim.opt.tabstop = 2      -- Number of spaces that <Tab> in the file counts for. (change only if expandtab = true).
vim.opt.softtabstop = 2  -- Number of spaces that <Tab> counts for while performing editing.
vim.opt.shiftwidth = 2   -- Numbers of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true -- Insert spaces instead of tabs.

-- Search
vim.opt.hlsearch = true  -- Highlight all the matches.
vim.opt.incsearch = true -- Show incremental matches while typing the search.

-- Clipboard (Force Nvim to use the OSC 52 provider that kitty supports)
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 30 })
  end,
})


--------------------------------------------------------------------------------------------------
-------------------------------------  Filetype Configs ------------------------------------------

vim.api.nvim_create_autocmd('BufEnter', {
  desc = "Markdown-specific settings",
  -- Change to * to apply to ALL buffers, not only files
  pattern = { "*.md", "*.markdown", "*.typ" },
  callback = function()
    if vim.bo.filetype == "markdown" or vim.bo.filetype == "typst" then
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
    end
  end,
})

--------------------------------------------------------------------------------------------------
--------------------------------------  Neovide Config -------------------------------------------

if vim.g.neovide then
  -- Theme
  vim.g.neovide_theme = 'auto'
  -- Flating window blurr
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- Floating window shadow
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
end


--------------------------------------------------------------------------------------------------
------------------------------------------  PACKER -----------------------------------------------

local packer = require 'packer'
local use = packer.use
packer.startup(function()
  use 'aiken-lang/editor-integration-nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'
  use "MunifTanjim/nui.nvim"
  use {
    '~/projects/audit.nvim',
    config = function()
      require('audit').setup()
    end
  }
end)

require('render-markdown').setup({
  file_types = { "markdown", "Avante" },
})



require("which-key").add({
  { "<Leader>n",  group = "notes" },
  { "<Leader>nn", ":AuditAddNote<CR>",        desc = "New Note",                mode = { "v" } },
  { "<Leader>nd", ":AuditDeleteNote<CR>",     desc = "Delete Note",             mode = { "n" } },
  { "<Leader>nr", ":AuditToggleReviewed<CR>", desc = "Mark/Unmark as reviewed", mode = { "v" } },
  { "<Leader>nt", ":AuditTogglePanel<CR>",    desc = "Toggle Panel",            mode = { "n" } },
  { "<Leader>ns", ":AuditSyncNotes<CR>",      desc = "Sync Notes",              mode = { "n" } },
})
