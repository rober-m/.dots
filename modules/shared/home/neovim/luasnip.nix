{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = luasnip; # Snippets engine plugin
        type = "lua";
        config =
          /*
          lua
          */
          ''
            ---------------------------------- LUASNIP ---------------------------------------
            require("luasnip.loaders.from_vscode").lazy_load()
            require'luasnip'.filetype_extend("dart", {"flutter"})
            ----------------------------------------------------------------------------------
          '';
      }
    ];

    extraPackages = with pkgs.vimPlugins; [
      friendly-snippets # Collection of snippets for various languages
    ];
  };
}
