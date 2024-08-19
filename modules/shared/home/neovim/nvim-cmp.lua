---------------------------------- NVIM-CMP ---------------------------------------
vim.cmd [[set completeopt=menu,menuone,noselect]]
-- DOCS: https://github.com/hrsh7th/nvim-cmp/
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require('lspkind') -- Plugin that adds icons to completion items.

-- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file#tab-completion-configuration-highly-recommended
-- Make it so that the menu still appears normally, but tab will fallback to indenting unless a non-whitespace character has actually been typed.
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

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
    -- { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer',  keyword_length = 5 },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- can also be a function to dynamically calculate max width such as
      -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      symbol_map = { Copilot = "" }, -- Add Copilot symbol to the lspkind symbol_map
      before = function(entry, vim_item)
        --...
        return vim_item
      end
    })
  }
})

-- TODO: Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-----------------------------------------------------------------------------------------
