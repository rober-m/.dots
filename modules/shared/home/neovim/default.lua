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
  --  use {
  --    "yetone/avante.nvim",
  --    build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
  --    commit = "deb3b03826119399610e23384ec75a29529437f6",
  --    dependencies = {
  --      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --      "stevearc/dressing.nvim",
  --      "nvim-lua/plenary.nvim",
  --      "MunifTanjim/nui.nvim",
  --      --- The below is optional, make sure to setup it properly if you have lazy=true
  --      {
  --        'MeanderingProgrammer/render-markdown.nvim',
  --        opts = {
  --          file_types = { "markdown", "Avante" },
  --        },
  --        ft = { "markdown", "Avante" },
  --      },
  --    },
  --  }
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
require('avante_lib').load()
require("avante").setup({
  {
    ---@alias Provider "openai" | "claude" | "azure"  | "copilot" | "cohere" | [string]
    provider = "claude",
    auto_suggestions_provider = "copilot", -- Auto-suggestions are a high-frequency operation and therefore expensive, use an inexpensive/free provider (e.g., copilot)
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20240620",
      api_key_name = "cmd:bw get notes anthropic-api-key",
      temperature = 0,
      max_tokens = 4096,
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
    hints = { enabled = true },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true,        -- similar to vim.o.wrap
      width = 30,         -- default % based on available width
      sidebar_header = {
        enabled = true,   -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
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
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
      --- Disable by setting to -1.
      override_timeoutlen = 500,
    },
  }
})
