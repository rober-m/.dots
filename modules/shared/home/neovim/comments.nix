{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = comment-nvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''

            ------------------------------------- COMMENTS-NVIM -------------------------------------
            -- DOCS: https://github.com/numtostr/comment.nvim/
            require("Comment").setup()
            -----------------------------------------------------------------------------------------
          '';
      }
    ];
  };
}
