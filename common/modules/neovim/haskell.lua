------------------------------------- HASKELL-TOOLS-NVIM -----------------------------------------
-- Docs: https://github.com/MrcJkb/haskell-tools.nvim/
-- This plugin automatically configures the haskell-language-server neovim client and integrateswith with other haskell tools.
-- Do not call the lspconfig.hls setup or set up the lsp manually, as doing so may cause conflicts.

local ht = require('haskell-tools')
local on_attach = function(client, bufnr)
  -- Show line diagnostics automatically in hover window
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  -- enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- format on save
  vim.cmd [[autocmd bufwritepre * lua vim.lsp.buf.format()]]

  -- mappings.
  -- see `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  require("which-key").register({
    ["gD"] = { vim.lsp.buf.declaration, "goto declaration" },
    ["gd"] = { vim.lsp.buf.definition, "goto definition" },
    ["K"] = { vim.lsp.buf.hover, "Hover" },
    ["gi"] = { vim.lsp.buf.implementation, "goto implementation" },
    ["gr"] = { vim.lsp.buf.references, "references" },
  })
  require("which-key").register({
    h = {
      name = "Haskell",
      a = { vim.lsp.codelens.run, "CodeLens" },
      h = { ht.hoogle.hoogle_signature, "Hoogle Signature" },
    },

  }, { prefix = "<leader>" })
end


ht.hls = { -- LSP client options
  on_attach = on_attach,
  settings = {
    haskell = {            -- haskell-language-server options
      formattingProvider = 'stylish-haskell',
      checkProject = true, -- Could have a performance impact on large mono repos.
    }
  }
}

ht.tools = { -- haskell-tools options
  repl = {
    -- Opt: 'builtin' (Use the simple builtin repl) | 'toggleterm' (Use akinsho/toggleterm.nvim)
    handler = 'toggleterm',
    builtin = {
      create_repl_window = function(view)
        -- create_repl_split | create_repl_vsplit | create_repl_tabnew | create_repl_cur_win
        return view.create_repl_split { size = vim.o.lines / 3 }
      end
    },
  },
  hover = {
    -- Stylize markdown (the builtin lsp's default behaviour).
    -- Setting this option to false sets the file type to markdown and enables
    -- Treesitter syntax highligting for Haskell snippets if nvim-treesitter is installed
    stylize_markdown = false
  },
}

require("which-key").register({
  h = {
    name = "Haskell",
    r = { ht.repl.toggle, "Toggle REPL" },
  },

}, { prefix = "<leader>" })
-----------------------------------------------------------------------------------------
