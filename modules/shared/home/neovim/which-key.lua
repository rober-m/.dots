------------------------------------- WHICH-KEY -----------------------------------------
require("which-key").setup {}

-- Movement
require("which-key").add({
  { "gh", "0", desc = "GoTo beginning of line" },
  { "gl", "$", desc = "GoTo end of line" },
})

-- Move highlighted lines
require("which-key").add({
  { "J", ":m '>+1<CR>gv=gv", desc = "Move line down", mode = 'v' },
  { "K", ":m '<-2<CR>gv=gv", desc = "Move line up",   mode = 'v' },
})

-- Copy and paster to clipboard
require("which-key").add({
  { "<leader>y", '"+y', desc = "Copy to clipboard",  mode = 'v' },
  { "<leader>p", '"+p', desc = "Paste to clipboard", mode = 'v' },
})

-- TODO: MacOS remaps. Generalize to Linux.
--local normal_pane_movements = {
--  ["∆"] = { "<C-w>j", "Move to pane below" },
--  ["˚"] = { "<C-w>k", "Move to pane above" },
--  ["˙"] = { "<C-w>h", "Move to left pane" },
--  ["¬"] = { "<C-w>l", "Move to right pane" },
--}
--
---- TODO: MacOS remaps. Generalize to Linux.
--local terminal_pane_movements = {
--  ["∆"] = { "<C-\\><C-N><C-w>j", "Move to pane below" },
--  ["˚"] = { "<C-\\><C-N><C-w>k", "Move to pane above" },
--  ["˙"] = { "<C-\\><C-N><C-w>h", "Move to left pane" },
--  ["¬"] = { "<C-\\><C-N><C-w>l", "Move to right pane" },
--}
--
---- TODO: MacOS remaps. Generalize to Linux.
--local macos_copy_paste = {
--  ["<D-c>"] = { '"+y', "Copy to clipboard" },
--  ["<D-v>"] = { '"+p', "Paste from clipboard" },
--}
--
--require("which-key").add(normal_pane_movements, { mode = 'n', silent = true })
--require("which-key").add(terminal_pane_movements, { mode = 't', silent = true })
--require("which-key").add(macos_copy_paste, { mode = 'v', silent = true })
-----------------------------------------------------------------------------------------
