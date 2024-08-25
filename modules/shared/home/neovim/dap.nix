# Debug Adapter Protocol
{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-dap; # Debug Adapter Protocol for Neovim
        type = "lua";
        config = builtins.readFile ./dap.lua;
      }
      #---------------------- Addons to nvim-dap -----------------------
      {
        plugin = nvim-dap-virtual-text; # Virtual text for nvim-dap
        type = "lua";
        config =
          /*
          lua
          */
          ''
            require('nvim-dap-virtual-text').setup();
          '';
      }
      {
        plugin = nvim-dap-ui;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            require('dapui').setup();
            require("which-key").add({
              { "<leader>d", group = "debug" },
              { "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", desc = "Toggle" },
              { "<leader>dx", "<cmd>lua require('dapui').open({reset = true})<CR>", desc = "Reset Windows size" },
              { "<leader>dd", "<cmd>lua require('dap').continue()<CR>", desc = "Continue" },
              { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
              { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>", desc = "Toggle REPL" },
              { "<leader>di", "<cmd>lua require('dap').step_into()<CR>", desc = "Step Into" },
              { "<leader>do", "<cmd>lua require('dap').step_over()<CR>", desc = "Step Over" },
              { "<leader>dO", "<cmd>lua require('dap').step_out()<CR>", desc = "Step Out" },
              { "<leader>dc", "<cmd>lua require('dap').run_to_cursor()<CR>", desc = "Run to Cursor" },
              { "<leader>dq", "<cmd>lua require('dap').close()<CR>", desc = "Quit" },
            });
          '';
      }
    ];

    extraPackages = with pkgs; [
      haskellPackages.haskell-dap # Haskell implementation of the DAP interface data
      haskellPackages.haskell-debug-adapter
      haskellPackages.ghci-dap # GHCi debugger adapter
    ];
  };
}
