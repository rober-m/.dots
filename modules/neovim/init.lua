-- -------
-- Library
-- -------

-- TODO: Figure out what this does. Nvim crashes if I remove it
function map (mode, shortcut, command)
vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end
function nmap(shortcut, command)
map('n', shortcut, command)
end
function imap(shortcut, command)
map('i', shortcut, command)
end

--------------------------------------------------------------------------------------------------
--------------------------------------  General Config -------------------------------------------

vim.g.mapleader = " "

vim.opt.wrap = false

-- Numbers
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Use relative line numbers

-- Tabs
vim.opt.tabstop = 2         -- Number of spaces that <Tab> in the file counts for. (change only if expandtab = true). 
vim.opt.softtabstop = 2     -- Number of spaces that <Tab> counts for while performing editing.
vim.opt.shiftwidth = 2      -- Numbers of spaces to use for each step of (auto)indent. 
vim.opt.expandtab = true    -- Insert spaces instead of tabs.

-- Search
vim.opt.hlsearch = true     -- Highlight all the matches.
vim.opt.incsearch = true    -- Show incremental matches while typing the search.
