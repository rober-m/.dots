{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Buffer tabs
      {
        plugin = leap-nvim;
        type = "lua";
        config = ''
          ---------------------------------------- LEAP -------------------------------------------
          -- Docs: https://github.com/ggandor/leap.nvim#usage
          require('leap').add_default_mappings()
          -----------------------------------------------------------------------------------------
        '';
      }
    ];
  };
}

