-- -------
-- Library
-- -------

-- Helper functions to easily define remaps
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

--------------------------------------------------------------------------------------------------
--------------------------------------  General Config -------------------------------------------

vim.g.mapleader = " " -- Leader key

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
  --use {
  --  'https://codeberg.org/esensar/nvim-dev-container', -- To use Devcontainers (Docker). DOCS: https://github.com/esensar/nvim-dev-container
  --  --requires = { 'nvim-treesitter/nvim-treesitter' }   -- Needed  to parse the config
  --}
  use 'aiken-lang/editor-integration-nvim'
  -- use {
  --   'akinsho/flutter-tools.nvim',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'stevearc/dressing.nvim', -- optional for vim.ui.select
  --   },
  -- }
  -- use 'AndreM222/copilot-lualine'
  use 'MeanderingProgrammer/render-markdown.nvim'
  use "MunifTanjim/nui.nvim"
  use {
    "yetone/avante.nvim",
    build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
    commit = "1c0623a9dfc717994085f9d9d68ab072f4b5a7a6",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
end)

require('render-markdown').setup({
  file_types = { "markdown", "Avante" },
})
--require("devcontainer").setup {}
--require("flutter-tools").setup {}
--
-------------------------------------------------------------------------
------------------------------ AVANTE ------------------------------------
--- DOCS: https://github.com/yetone/avante.nvim

require("which-key").add({
  { "<leader>a", group = "avante", mode = { 'n', 'v' } },
})
require("avante").setup({
  {
    ---@alias Provider "openai" | "claude" | "azure"  | "copilot" | "cohere" | [string]
    provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20240620",
      api_key_name = "cmd:bw get notes anthropic-api-key",
      temperature = 0,
      max_tokens = 4096,
    },
    mappings = {
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        both = "cb",
        next = "]x",
        prev = "[x",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      toggle = {
        debug = "<leader>ad",
        hint = "<leader>ah",
      },
    },
    hints = { enabled = true },
    windows = {
      wrap = true,        -- similar to vim.o.wrap
      width = 30,         -- default % based on available width
      sidebar_header = {
        align = "center", -- left, center, right for title
        rounded = true,
      },
    },
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    --- @class AvanteConflictUserConfig
    diff = {
      debug = false,
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
    },
  }
})
