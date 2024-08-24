---------------------------------- BUFFERLINE-NVIM --------------------------------------
-- DOCS: https://github.com/akinsho/bufferline.nvim
-- You can close buffers by clicking the close icon or by right clicking the tab anywhere

require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
            or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end
  }
}

require("which-key").add({
  { "<leader>b",  group = "buffer" },
  { "<leader>bl", ":BufferLineCycleNext<cr>",   desc = "Cycle Next" },
  { "<leader>bh", ":BufferLineCyclePrev<cr>",   desc = "Cycle Prev" },
  { "<leader>bc", ":bd<cr>",                    desc = "Close" },
  { "<leader>bC", ":bd!<cr>",                   desc = "Close without saving" },
  { "<leader>bo", ":BufferLineCloseOthers<cr>", desc = "Close Others" },
})

-----------------------------------------------------------------------------------------
