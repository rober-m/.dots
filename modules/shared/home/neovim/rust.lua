----------------------------- RUSTACEANVIM -----------------------------
--- DOCS: https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#books-usage--features
local bufnr = vim.api.nvim_get_current_buf()
require('which-key').add({
  { '<leader>r',  group = 'Rust' },
  { '<leader>rm', '<cmd>RustExpand<cr>',           desc = 'Expand Macro',                 buffer = bufnr },
  { '<leader>re', '<cmd>RustLsp explainError<cr>', desc = 'Explain error (if available)', buffer = bufnr },
})
