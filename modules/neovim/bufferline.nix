{ pkgs, inputs, system, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Buffer tabs
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          ---------------------------------- NVIM-LSPCONFIG ---------------------------------------
          -- Docs: https://github.com/akinsho/bufferline.nvim
          -- You can close buffers by clicking the close icon or by right clicking the tab anywhere
          require("bufferline").setup{
            options = {
              diagnostics = "nvim_lsp",
              diagnostics_indicator = function(count, level, diagnostics_dict, context)
	        local s = " "
	        for e, n in pairs(diagnostics_dict) do
		  local sym = e == "error" and " "
		    or (e == "warning" and " " or "" )
		  s = s .. n .. sym
	        end
	        return s
	      end
            }
          }

          require("which-key").register({
                                b = {
                                  name = "Buffer",
                                  h = { ":BufferLineCycleNext<cr>", "Cycle Next" },
                                  l = { ":BufferLineCyclePrev<cr>", "Cycle Prev" },
                                  c = { ":bd<cr>", "Close" },
                                  C = { ":bd!<cr>", "Close without saving" },
                                },
                              }, { prefix = "<leader>" })

          ----------------------------------------------------------------------------------------- 
        '';
      }
    ];

  };
}

