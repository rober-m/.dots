{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lazygit-nvim;
        type = "lua";
        config = ''
          --------------------------------------- LAZYGIT -----------------------------------------
          require("which-key").register({
                                g = {
                                  name = "git",
                                  g = { ":LazyGit<cr>", "LazyGit" },
                                },
                              }, { prefix = "<leader>" })
          -----------------------------------------------------------------------------------------
        '';
      }
    ];

    extraPackages = with pkgs; [
      lazygit
    ];
  };
}
