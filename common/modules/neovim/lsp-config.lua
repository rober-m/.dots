---------------------------------- NVIM-LSPCONFIG ---------------------------------------
-- Docs: https://github.com/neovim/nvim-lspconfig/
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- Set the time it takes for the "CursorHold" function (inside on_attach) to run.
-- This setting is global and should be set only once
vim.o.updatetime = 100

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

local opts = { noremap = true, silent = true }
require("which-key").register({
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    r = { vim.lsp.buf.rename, "Rename" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    j = { vim.diagnostic.goto_next, "Next Diagnostic", },
    k = { vim.diagnostic.goto_prev, "Prev Diagnostic", },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    i = { "<cmd>LspInfo<cr>", "LSP Info" },
    x = { "<cmd>:LspRestart<cr>", "LSP Restart" },
  },
}, { prefix = "<leader>" })

-- Use an on_attach function to only map the following keys after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Format on save
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

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

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  require("which-key").register({
    ["gD"] = { vim.lsp.buf.declaration, "GoTo Declaration" },
    ["gd"] = { vim.lsp.buf.definition, "GoTo Definition" },
    ["K"] = { vim.lsp.buf.hover, "Hover" },
    ["gi"] = { vim.lsp.buf.implementation, "GoTo Implementation" },
    ["gr"] = { vim.lsp.buf.references, "References" },
    ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Help" },
  })
  require("which-key").register({
    l = {
      name = "LSP",
      t = { vim.lsp.buf.type_definition, "Type definition" },
    },
  }, { prefix = "<leader>" })
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Servers without specific config (Haskell server managed in haskell.nix)
local servers = {
  'tsserver',      -- Typescript
  'nil_ls',        -- Nix
  'lua_ls',        -- Lua
  'rust_analyzer', -- Rust
  'yamlls',        -- Yaml
  'bashls',        -- Bash
  'vimls',         -- Vim
  'html',          -- HTML   (vscode-langservers-extracted)
  'cssls',         -- CSS    (vscode-langservers-extracted)
  'eslint',        -- ESLint (vscode-langservers-extracted)
  'jsonls',        -- JSON   (vscode-langservers-extracted)
  --'tailwindcss',   -- Tailwind CSS FIXME: Uncomment after installation is fixed
  'marksman',      -- Markdown
  'aiken',         -- Aiken
  --,'ltex'         -- LaTeX and Markdown
}

for _, server in ipairs(servers) do
  require('lspconfig')[server].setup {
    on_attach = on_attach,
    flags = lsp_flags,
  }
end

require('lspconfig').nil_ls.setup {
  on_attach = on_attach,
  settings = {
    ['nil'] = {
      formatting = {
        --command = { "nixpkgs-fmt" },
        command = { "alejandra" },
      },
    },
  },
}

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },
}
-----------------------------------------------------------------------------------------
