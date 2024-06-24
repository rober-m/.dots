{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-notify; # Notifications for Nvim. Docs: https://github.com/rcarriga/nvim-notify/
        type = "lua";
        config =
          /*
          lua
          */
          ''
            ----------------------------------- NVIM-NOTIFY ----------------------------------------
            -- NOTE: Make sure to use a font with supported icons (nerd-fonts)
            vim.opt.termguicolors = true -- 24-bit colour is required
            require("notify").setup({
              background_colour = "#000000",
            })
            vim.notify = require("notify")
            -----------------------------------------------------------------------------------------
          '';
      }
    ];
  };
}
