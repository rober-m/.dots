{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      #--------------------- Copilot-lua --------------------
      {
        plugin = copilot-lua;
        type = "lua";
        config = builtins.readFile ./copilot.lua;
      }
      #---------- Integrate Copilot-lua with cmp ------------
      # Important! compilot-cmp requires copilot-lua suggestions and pane to be disabled
      # DOCS: https://github.com/zbirenbaum/copilot-cmp
      # INFO: I disabled this because it didn't feel natural. But I should try it again some time in the future
      # {
      #   plugin = copilot-cmp;
      #   type = "lua";
      #   config =
      #     /*
      #     lua
      #     */
      #     ''
      #       require
      #       "copilot_cmp".setup {}
      #     '';
      # }
    ];
  };
}
