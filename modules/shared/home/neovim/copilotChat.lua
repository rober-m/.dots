---------------------------------- COPILOTCHAT ---------------------------------------
-- DOCS: https://github.com/CopilotC-Nvim/CopilotChat.nvim/
-- Config originally copied from:
-- https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/copilot-chat-v2.lua

-------------------- GENERAL CONFIG ------------------------------

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

local opts = {
  question_header = "## User ",
  answer_header = "## Copilot ",
  error_header = "## Error ",
  prompts = prompts,
  auto_follow_cursor = false, -- Don't follow the cursor after getting response
  show_help = true,           -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
  chat_autocomplete = true,   -- Enable autocomplete for chat
  mappings = {
    -- Use tab for completion
    complete = {
      detail = "Use @<Tab> or /<Tab> for options.",
      insert = "<Tab>",
    },
    -- Close the chat
    close = {
      normal = "q",
      insert = "<C-c>",
    },
    -- Reset the chat buffer
    reset = {
      normal = "<C-x>",
      insert = "<C-x>",
    },
    -- Submit the prompt to Copilot
    submit_prompt = {
      normal = "<CR>",
      insert = "<C-CR>",
    },
    -- Accept the diff
    accept_diff = {
      normal = "<C-y>",
      insert = "<C-y>",
    },
    -- Yank the diff in the response to register
    yank_diff = {
      normal = "gmy",
    },
    -- Show the diff
    show_diff = {
      normal = "gmd",
    },
    -- Show the prompt
    show_info = {
      normal = "gmp",
    },
    -- Show the user selection
    show_context = {
      normal = "gms",
    },
  },
}

local chat = require("CopilotChat")
local select = require("CopilotChat.select")
-- Use unnamed register for the selection
opts.selection = select.unnamed

-- Override the git prompts message
opts.prompts.Commit = {
  prompt = "Write commit message for the change with commitizen convention",
  selection = select.gitdiff,
}
opts.prompts.CommitStaged = {
  prompt = "Write commit message for the change with commitizen convention",
  selection = function(source)
    return select.gitdiff(source, true)
  end,
}

chat.setup(opts)

-------------------- CUSTOM COMMANDS ------------------------

vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
  chat.ask(args.args, { selection = select.visual })
end, { nargs = "*", range = true })

-- Inline chat with Copilot
vim.api.nvim_create_user_command("CopilotChatInline", function(args)
  chat.ask(args.args, {
    selection = select.visual,
    window = {
      layout = "float",
      relative = "cursor",
      width = 1,
      height = 0.4,
      row = 1,
    },
  })
end, { nargs = "*", range = true })

-- Restore CopilotChatBuffer
vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
  chat.ask(args.args, { selection = select.buffer })
end, { nargs = "*", range = true })

-- Custom buffer for CopilotChat
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    vim.opt_local.relativenumber = true
    vim.opt_local.number = true

    -- Get current filetype and set it to markdown if the current filetype is copilot-chat
    local ft = vim.bo.filetype
    if ft == "copilot-chat" then
      vim.bo.filetype = "markdown"
    end
  end,
})

-------------------- KEYBINDINGS ------------------------

-- Add which-key mappings
local wk = require("which-key")
wk.add({
  { "<leader>c",  group = "Copilot Chat" },
  -- Show help actions with telescope
  {
    "<leader>ch",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.help_actions())
    end,
    desc = "Help actions",
  },
  -- Show prompts actions with telescope
  {
    "<leader>cp",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end,
    desc = "Prompt actions",
  },
  -- Code related commands
  { "<leader>ce", "<cmd>CopilotChatExplain<cr>",       desc = "Explain code" },
  { "<leader>ct", "<cmd>CopilotChatTests<cr>",         desc = "Generate tests" },
  { "<leader>cr", "<cmd>CopilotChatReview<cr>",        desc = "Review code" },
  { "<leader>cR", "<cmd>CopilotChatRefactor<cr>",      desc = "Refactor code" },
  { "<leader>cn", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },
  -- Custom input for CopilotChat
  {
    "<leader>ci",
    function()
      local input = vim.fn.input("Ask Copilot: ")
      if input ~= "" then
        vim.cmd("CopilotChat " .. input)
      end
    end,
    desc = "Ask input",
  },
  -- Generate commit message based on the git diff
  {
    "<leader>cm",
    "<cmd>CopilotChatCommit<cr>",
    desc = "Generate commit message for all changes",
  },
  {
    "<leader>cM",
    "<cmd>CopilotChatCommitStaged<cr>",
    desc = "Generate commit message for staged changes",
  },
  -- Quick chat with Copilot
  {
    "<leader>cc",
    function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        vim.cmd("CopilotChatBuffer " .. input)
      end
    end,
    desc = "Quick chat",
  },
  -- Debug
  { "<leader>cd", "<cmd>CopilotChatDebugInfo<cr>",     desc = "Debug Info" },
  -- Fix the issue with diagnostic
  { "<leader>cf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
  -- Clear buffer and chat history
  { "<leader>cl", "<cmd>CopilotChatReset<cr>",         desc = "Clear buffer and chat history" },
  -- Toggle Copilot Chat Vsplit
  { "<leader>cv", "<cmd>CopilotChatToggle<cr>",        desc = "Toggle" },
}
)

wk.add({
  {
    "<leader>cp",
    ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
    desc = "Prompt actions",
    mode = "v",
  },
  -- Chat with Copilot in visual mode
  {
    "<leader>cv",
    ":CopilotChatVisual<cr>",
    desc = "Open in vertical split",
    mode = "v",
  },
  {
    "<leader>ci",
    ":CopilotChatInline<cr>",
    desc = "Inline chat",
    mode = "v",
  }
})
