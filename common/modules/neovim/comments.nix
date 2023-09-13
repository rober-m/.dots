{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''

          ------------------------------------- COMMENTS-NVIM -------------------------------------
          -- Docs: https://github.com/numtostr/comment.nvim/
          require("Comment").setup()
          -----------------------------------------------------------------------------------------
        '';
      }
    ];
  };
}
