---------------------------------- NVIM-CMP ---------------------------------------
vim.cmd [[set completeopt=menu,menuone,noselect]]
-- Docs: https://github.com/hrsh7th/nvim-cmp/
local cmp = require 'cmp'
local luasnip = require 'luasnip'
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
    --['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-,>'] = cmp.mapping.complete(),
    --['<C-e>'] = cmp.mapping.abort(),
    --['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          -- If the expandable snippet is present, expand it.
          luasnip.expand()
        else
          -- Otherwise, confirm the selection.
          cmp.confirm({
            -- Accept currently selected item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            select = false,
          })
        end
      else
        fallback()
      end
    end),
    ['<Tab>'] = cmp.mapping(function(fallback)
      -- If I'm not inside a snippet, use the default completion (likely Copilot).
      if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      -- If I'm not inside a snippet, use the default completion (likely Copilot).
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
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
