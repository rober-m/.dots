------------------------------------- WHICH-KEY -----------------------------------------
require("which-key").setup {

  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
require("which-key").register({
  ["gh"] = { "0", "GoTo beginning of line" },
  ["gl"] = { "$", "GoTo end of line" },
})

-- TODO: MacOS remaps. Generalize to Linux.
local normal_pane_movements = {
  ["∆"] = { "<C-w>j", "Move to pane below" },
  ["˚"] = { "<C-w>k", "Move to pane above" },
  ["˙"] = { "<C-w>h", "Move to left pane" },
  ["¬"] = { "<C-w>l", "Move to right pane" },
}

-- TODO: MacOS remaps. Generalize to Linux.
local terminal_pane_movements = {
  ["∆"] = { "<C-\\><C-N><C-w>j", "Move to pane below" },
  ["˚"] = { "<C-\\><C-N><C-w>k", "Move to pane above" },
  ["˙"] = { "<C-\\><C-N><C-w>h", "Move to left pane" },
  ["¬"] = { "<C-\\><C-N><C-w>l", "Move to right pane" },
}

-- TODO: MacOS remaps. Generalize to Linux.
local macos_copy_paste = {
  ["<D-c>"] = { '"+y', "Copy to clipboard" },
  ["<D-v>"] = { '"+p', "Paste from clipboard" },
}

require("which-key").register(normal_pane_movements, { mode = 'n', silent = true })
require("which-key").register(terminal_pane_movements, { mode = 't', silent = true })
require("which-key").register(macos_copy_paste, { mode = 'v', silent = true })
-----------------------------------------------------------------------------------------
