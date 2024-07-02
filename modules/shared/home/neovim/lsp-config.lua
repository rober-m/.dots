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
      h = { "<cmd> lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", "Toggle Inlay Hints" },
    },
  }, { prefix = "<leader>" })
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- NOT TRUE ANYMORE (see below): Servers without specific config (Haskell server managed in haskell.nix)
local servers_with_shared_config = {
  -- 'denols',        -- Deno (It works, but it's annoying when using NodeJS)
  'rust_analyzer', -- Rust
  'yamlls',        -- Yaml
  'bashls',        -- Bash
  'vimls',         -- Vim
  'html',          -- HTML   (vscode-langservers-extracted)
  'cssls',         -- CSS    (vscode-langservers-extracted)
  'eslint',        -- ESLint (vscode-langservers-extracted)
  'jsonls',        -- JSON   (vscode-langservers-extracted)
  'tailwindcss',   -- Tailwind CSS FIXME: Uncomment after installation is fixed
  'marksman',      -- Markdown (INFO: Format requests will fail because the LSP isn't capable of formatting!! See features: https://github.com/artempyanykh/marksman/blob/main/docs/features.md)
  'aiken',         -- Aiken
  --,'ltex'         -- LaTeX and Markdown
  'terraformls',   -- Terraform
  'dartls',        -- Dart (Language Server provided by `dart`)
}

for _, server in ipairs(servers_with_shared_config) do
  require('lspconfig')[server].setup {
    on_attach = on_attach,
    flags = lsp_flags,
  }
end

require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayVariableTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayVariableTypeHints = true,

        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

require('lspconfig').hls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- filetypes = { 'haskell', 'lhaskell', 'cabal' },
  -- rootPatterns = { "*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml" },
  settings = {
    haskell = {
      -- checkParents = "CheckOnSave",
      -- checkProject = true,
      -- cabalFormattingProvider = "cabalfmt",
      formattingProvider = 'stylish-haskell',
    },
  },
}

require('lspconfig').nil_ls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
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
  flags = lsp_flags,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      hint = { enable = true },
    },
  },
}
-----------------------------------------------------------------------------------------
