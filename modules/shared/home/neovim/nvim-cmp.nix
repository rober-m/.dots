{pkgs, ...}: {
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
      lspkind-nvim # Add icons to LSP completion menu


      # MAIN CONFIG
      {
        # This pluging provides an engine to have suggested competions based
        # on the completion providers (see extraPackages below)
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./nvim-cmp.lua;
      }
    ];
  };
}
