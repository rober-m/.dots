----------------------------- RUSTACEANVIM -----------------------------
--- DOCS: https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#books-usage--features
local bufnr = vim.api.nvim_get_current_buf()
require('which-key').register({
  r = {
    name = 'Rust',
    m = { '<cmd>RustExpand<cr>', 'Expand Macro' },
    e = { '<cmd>RustLsp explainError<cr>', 'Explain error (if available)' },
  }
}, { prefix = '<leader>', buffer = bufnr })
