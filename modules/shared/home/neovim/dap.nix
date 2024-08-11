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
            require("which-key").register({
              d = {
                name = "+debug",
                t = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle" },
                x = { "<cmd>lua require('dapui').open({reset = true})<CR>", "Reset Windows size" },
                d = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
                b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
                r = { "<cmd>lua require('dap').repl.toggle()<CR>", "Toggle REPL" },
                i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
                o = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
                O = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
                c = { "<cmd>lua require('dap').run_to_cursor()<CR>", "Run to Cursor" },
                q = { "<cmd>lua require('dap').close()<CR>", "Quit" },
              },
            }, { prefix = "<leader>" });
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
