---------------------------------- NVIM-CMP ---------------------------------------
vim.cmd [[set completeopt=menu,menuone,noselect]]
-- Docs: https://github.com/hrsh7th/nvim-cmp/
local cmp = require 'cmp'
cmp.setup({
  -- completion = {
  -- completeopt = 'menu,menuone,noinsert'
  --},
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    -- The sources enabled globally. The order (top to bottom) is the priority of where the suggestions show up.
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer',  keyword_length = 5 },
  })
})
-- TODO: Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-----------------------------------------------------------------------------------------
