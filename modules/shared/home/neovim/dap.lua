--------------------------- Debug Adapter Protocol ----------------------------
-- DOCS: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local dap = require("dap")
---------------- Setup for Haskell ------------------
--dap.adapters.haskell = {
--  type = 'executable',
--  command = 'haskell-debug-adapter',
--  args = { '--hackage-version=0.0.33.0' },
--}
--dap.configurations.haskell = {
--  {
--    type = 'haskell',
--    request = 'launch',
--    name = 'Debug',
--    workspace = '${workspaceFolder}',
--    startup = "${file}",
--    stopOnEntry = true,
--    logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
--    logLevel = 'WARNING',
--    ghciEnv = vim.empty_dict(),
--    ghciPrompt = "λ: ",
--    -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
--    ghciInitialPrompt = "λ: ",
--    --ghciCmd = "ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
--    ghciCmd = "cabal repl"
--  },
--}

dap.adapters.haskell = {
  type = 'executable',
  command = 'haskell-debug-adapter',
}

dap.configurations.haskell = { {
  type = 'haskell',
  request = 'launch',
  name = 'haskell(cabal)',
  workspace = '${workspaceFolder}',
  startup = "${workspaceFolder}/app/Main.hs",
  stopOnEntry = false,
  logFile = vim.fn.stdpath('cache') .. '/haskell-dap.log',
  logLevel = 'WARNING',
  ghciEnv = vim.empty_dict(),
  ghciPrompt = "λ: ",
  ghciInitialPrompt = "λ: ",
  --ghciCmd = "cabal exec -- ghci-dap --interactive -i -i${workspaceFolder}",
  ghciCmd = "cabal repl",
} }
