{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Buffer tabs
      {
        plugin = leap-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            ---------------------------------------- LEAP -------------------------------------------
            -- DOCS: https://github.com/ggandor/leap.nvim#usage
            require('leap').add_default_mappings()
            -----------------------------------------------------------------------------------------
          '';
      }
    ];
  };
}
