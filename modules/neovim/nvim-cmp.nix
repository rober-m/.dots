{ pkgs, inputs, system, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [

      # COMPLETION PROVIDERS
      cmp-nvim-lsp # Completes with LSP server (Auto import, snippets, etc.)
      cmp-path # Completes files
      cmp-nvim-lua # Completes with Lua and Neovim keywords
      cmp-buffer # Completes with word on the current buffer
      luasnip # Snippet Engine for Neovim written in Lua. (there are other options).
      cmp_luasnip # Completes with snippets from luasnip

      # ICONS
      nvim-web-devicons # Adds icons to my pluggins

      # MAIN CONFIG
      {
        # This pluging provides an engine to have suggested competions based
        # on the completion providers (see extraPackages below)
        plugin = nvim-cmp;
        #type = "lua";
        config = ''
          " Start of NVIM-CMP config
          set completeopt=menu,menuone,noselect
          lua << EOF
          ---------------------------------- NVIM-CMP ---------------------------------------
          -- Docs: https://github.com/hrsh7th/nvim-cmp/
          local cmp = require 'cmp'
          cmp.setup({
            -- completion = {
              -- completeopt = 'menu,menuone,noinsert'
            --},
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end,
            },
            window = {
              -- completion = cmp.config.window.bordered(),
              -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
              -- The sources enabled globally. The order (top to bottom) is the priority of where the suggestions show up.
              { name = 'nvim_lsp' },
              { name = 'path' },
              { name = 'luasnip' },
              { name = 'buffer', keyword_length = 5 },
            })
          })
          -- TODO: Set up lspconfig.
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          ----------------------------------------------------------------------------------------- 
          EOF
        '';
      }
    ];

    # extraConfig goes in a .vim file, not .lua!
    # extraConfig = ''
    #   set completeopt=menu,menuone,noselect
    # '';

  };
}

