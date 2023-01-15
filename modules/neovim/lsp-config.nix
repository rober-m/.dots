{ pkgs, inputs, system, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        # This pluging provides default configurations for LSP neovim clients.
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          ---------------------------------- NVIM-LSPCONFIG ---------------------------------------
          -- Docs: https://github.com/neovim/nvim-lspconfig/
          -- Mappings.
          -- See `:help vim.diagnostic.*` for documentation on any of the below functions

          -- Set the time it takes for the "CursorHold" function (inside on_attach) to run.
          -- This setting is global and should be set only once
          vim.o.updatetime = 100

          vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = true,
          })

          local opts = { noremap=true, silent=true }
          require("which-key").register({
                                l = {
                                  name = "LSP",
                                  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
                                  d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
                                  w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
                                  i = { "<cmd>LspInfo<cr>", "Info" },
                                  j = { vim.diagnostic.goto_next, "Next Diagnostic", },
                                  k = { vim.diagnostic.goto_prev, "Prev Diagnostic", },
                                  l = { vim.lsp.codelens.run, "CodeLens Action" },
                                  q = { vim.diagnostic.setloclist, "Quickfix" },
                                  r = { vim.lsp.buf.rename, "Rename" },
                                  s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
                                  S = {
                                    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                                    "Workspace Symbols",
                                  },
                                  e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
                                },
                              }, { prefix = "<leader>" })

          -- Use an on_attach function to only map the following keys after the language server 
          -- attaches to the current buffer
          local on_attach = function(client, bufnr)

            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Format on save
            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

            -- Show line diagnostics automatically in hover window
            vim.api.nvim_create_autocmd("CursorHold", {
              buffer = bufnr,
              callback = function()
                local opts = {
                  focusable = false,
                  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                  border = 'rounded',
                  source = 'always',
                  prefix = ' ',
                  scope = 'cursor',
                }
                vim.diagnostic.open_float(nil, opts)
              end
            })

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap=true, silent=true, buffer=bufnr }

            require("which-key").register({
              ["gD"] = { vim.lsp.buf.declaration, "GoTo Declaration"},
              ["gd"] = { vim.lsp.buf.definition, "GoTo Definition"},
              ["K"] = { vim.lsp.buf.hover, "Hover"},
              ["gi"] = { vim.lsp.buf.implementation, "GoTo Implementation"},
              ["gr"] = { vim.lsp.buf.references, "References"},
              ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Help"},
            })
            require("which-key").register({
              l = {
                name = "LSP",
                t = { vim.lsp.buf.type_definition, "Type definition" },
              },
              }, { prefix = "<leader>" })
          end

          local lsp_flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
          }
          require('lspconfig')['tsserver'].setup{
              on_attach = on_attach,
              flags = lsp_flags,
          }
          -- require('lspconfig')['hls'].setup{
          --     on_attach = on_attach,
          --     flags = lsp_flags,
          -- }
          require('lspconfig')['rnix'].setup{
              on_attach = on_attach,
              flags = lsp_flags,
          }
          require('lspconfig')['sumneko_lua'].setup{
              on_attach = on_attach,
              flags = lsp_flags,
          }
          require('lspconfig')['rust_analyzer'].setup{
              on_attach = on_attach,
              flags = lsp_flags,
              -- Server-specific settings...
              settings = {
                ["rust-analyzer"] = {}
              }
          }
          ----------------------------------------------------------------------------------------- 
        '';
      }
    ];

    extraPackages = with pkgs; [

      # LANGUAGE SERVERS
      haskell-language-server # Haskell
      rnix-lsp # Nix
      sumneko-lua-language-server # Lua
      rust-analyzer # Rust
      nodePackages.vim-language-server # Vim
      nodePackages.typescript-language-server # Typescript
      nodePackages.yaml-language-server # Yaml
      nodePackages.bash-language-server # Bash
      nodePackages.vscode-langservers-extracted # HTML/CSS/JSON/ESLint extracted from VSCode

    ];

  };
}

