---------------------------------- NVIM-LSPCONFIG ---------------------------------------
-- DOCS: https://github.com/neovim/nvim-lspconfig/
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
require("which-key").add({
  { "<leader>l",  group = "lsp" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",               desc = "Code Action" },
  { "<leader>ll", vim.lsp.codelens.run,                                   desc = "CodeLens Action" },
  { "<leader>lr", vim.lsp.buf.rename,                                     desc = "Rename" },
  { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics" },
  { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                       desc = "Diagnostics" },
  { "<leader>lj", vim.diagnostic.goto_next,                               desc = "Next Diagnostic", },
  { "<leader>lk", vim.diagnostic.goto_prev,                               desc = "Prev Diagnostic", },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",              desc = "Document Symbols" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",     desc = "Workspace Symbols", },
  { "<leader>li", "<cmd>LspInfo<cr>",                                     desc = "LSP Info" },
  { "<leader>lx", "<cmd>:LspRestart<cr>",                                 desc = "LSP Restart" },
})

-- Use an on_attach function to only map the following keys after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Format on save (except for the marksman LSP. But the filter didn't work. TODO: investingate)
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({ filter = function(client) return client.name ~= "marksman" end })]]

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

  require("which-key").add({
    { "gD",         vim.lsp.buf.declaration,                                                        desc = "goto declaration" },
    { "gd",         vim.lsp.buf.definition,                                                         desc = "goto definition" },
    { "K",          vim.lsp.buf.hover,                                                              desc = "Hover" },
    { "gi",         vim.lsp.buf.implementation,                                                     desc = "goto implementation" },
    { "gr",         vim.lsp.buf.references,                                                         desc = "references" },
    { "<C-k>",      vim.lsp.buf.signature_help,                                                     desc = "Signature Help" },
    { "<leader>l",  group = "lsp" },
    { "<leader>lt", vim.lsp.buf.type_definition,                                                    desc = "Type Definition" },
    { "<leader>lh", "<cmd> lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", desc = "Toggle Inlay Hints" },
  })
end

-- NOT TRUE ANYMORE (see below): Servers without specific config (Haskell server managed in haskell.nix)
local servers_with_shared_config = {
  -- 'denols',        -- Deno (It works, but it's annoying when using NodeJS)
  -- 'rust_analyzer', -- Rust (I use rustacean.nix)
  'yamlls',      -- Yaml
  'bashls',      -- Bash
  'vimls',       -- Vim
  'html',        -- HTML   (vscode-langservers-extracted)
  'cssls',       -- CSS    (vscode-langservers-extracted)
  'eslint',      -- ESLint (vscode-langservers-extracted)
  'jsonls',      -- JSON   (vscode-langservers-extracted)
  'tailwindcss', -- Tailwind CSS
  'marksman',    -- Markdown (INFO: Format requests will fail because the LSP isn't capable of formatting!! See features: https://github.com/artempyanykh/marksman/blob/main/docs/features.md)
  'aiken',       -- Aiken
  -- 'ltex',         -- LaTeX and Markdown
  'terraformls', -- Terraform
  'dartls',      -- Dart (Language Server provided by `dart`)
}

for _, server in ipairs(servers_with_shared_config) do
  require('lspconfig')[server].setup {
    on_attach = on_attach,
  }
end

require('lspconfig').ts_ls.setup {
  on_attach = on_attach,
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

--require('lspconfig').hls.setup {
--  on_attach = on_attach,
--  -- filetypes = { 'haskell', 'lhaskell', 'cabal' },
--  -- rootPatterns = { "*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml" },
--  settings = {
--    haskell = {
--      -- checkParents = "CheckOnSave",
--      -- checkProject = true,
--      -- cabalFormattingProvider = "cabalfmt",
--      formattingProvider = 'stylish-haskell',
--    },
--  },
--}

require('lspconfig').nil_ls.setup {
  on_attach = on_attach,
  settings = {
    --nix = {
    --  flake = {
    --    -- calls `nix flake archive` to put a flake and its output to store
    --    -- (to solve "Your LSP client doesn't support confirmation" message)
    --    autoArchive = true,
    --  },
    --},
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
      hint = { enable = true },
    },
  },
}

require('lspconfig').tinymist.setup {
  on_attach = on_attach,
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onSave",
    semanticTokens = "enable"
  }
}
-----------------------------------------------------------------------------------------
