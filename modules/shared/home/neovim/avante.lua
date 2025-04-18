-------------------------------------------------------------------------
------------------------------ AVANTE ------------------------------------
--- DOCS: https://github.com/yetone/avante.nvim

require("which-key").add({
  { "<leader>a", group = "avante", mode = { 'n', 'v' } },
})
require('avante_lib').load()
require("avante").setup({
  {
    provider = "copilot",                  -- "openai" | "claude" | "azure"  | "copilot" | "cohere" | [string]
    auto_suggestions_provider = "copilot", -- Auto-suggestions are a high-frequency operation and therefore expensive, use an inexpensive/free provider (e.g., copilot)
    --claude = {
    --  endpoint = "https://api.anthropic.com",
    --  model = "claude-3-5-sonnet-20240620",
    --  api_key_name = "cmd:bw get notes anthropic-api-key",
    --  temperature = 0,
    --  max_tokens = 4096,
    --},
    behaviour = {
      auto_suggestions = true, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = true,
      support_paste_from_clipboard = false,
    },
    mappings = {
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
        retry_user_request = "r",
        edit_user_request = "e",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "@",
        close = { "<Esc>", "q" },
        close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
      },
    },
    hints = { enabled = true },
    windows = {
      position = "right", -- the position of the sidebar: "right" | "left" | "top" | "bottom"
      wrap = true,        -- similar to vim.o.wrap
      width = 30,         -- default % based on available width
      sidebar_header = {
        enabled = true,   -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "👨> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false,        -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true,     -- Start insert mode when opening the ask window
        border = "rounded",
        focus_on_apply = "ours", -- which diff to focus after applying: "ours" | "theirs"
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    diff = {
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
      --- Disable by setting to -1.
      override_timeoutlen = 500,
    },
    suggestion = {
      debounce = 600,
      throttle = 600,
    },
  }
})

-----------------------------------------------------------------------------------------
