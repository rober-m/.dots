{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Buffer tabs
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          ------------------------------------- LUALINE -------------------------------------------
          require('lualine').setup {
           -- options = {
           --   theme = 'tokyonight'
           -- }
          }
          -----------------------------------------------------------------------------------------
        '';
      }
    ];

    extraPackages = with pkgs; [
      vimPlugins.nvim-web-devicons
    ];
  };
}
