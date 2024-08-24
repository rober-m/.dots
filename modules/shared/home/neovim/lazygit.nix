{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lazygit-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            --------------------------------------- LAZYGIT -----------------------------------------
            require("which-key").add({
                { "<leader>g", group = "git" },
                { "<leader>gg", ":LazyGit<cr>", desc ="LazyGit" },
            })
            -----------------------------------------------------------------------------------------
          '';
      }
    ];

    extraPackages = with pkgs; [
      lazygit
    ];
  };
}
