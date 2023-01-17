{ pkgs, inputs, system, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Tree file explorer.
      # Docs: https://github.com/nvim-tree/nvim-tree.lua/
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          ---------------------------------- NVIM-TREE-LUA ----------------------------------------
          -- Disable netrw at the very start of your init.lua (strongly advised)
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1

          -- Set termguicolors to enable highlight groups
          vim.opt.termguicolors = true

          -- Empty setup using defaults
          require("nvim-tree").setup()

          -- Remappings
          nmap("<C-e>", ":NvimTreeToggle<cr>")
          imap("<C-e>", ":NvimTreeToggle<cr>")

          -- Hack to close nvim-tree when last buffer. See:
          -- https://github.com/nvim-tree/nvim-tree.lua/issues/1368#issuecomment-1195557960
          vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
            pattern = "NvimTree_*",
            callback = function()
              local layout = vim.api.nvim_call_function("winlayout", {})
              if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
            end
          })
          ----------------------------------------------------------------------------------------- 
        '';
      }
    ];

    extraPackages = with pkgs; [
      vimPlugins.nvim-web-devicons
    ];

  };
}
