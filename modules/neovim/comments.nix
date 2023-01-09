{ pkgs, inputs, system, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Docs: https://github.com/numtostr/comment.nvim/
      comment-nvim

    ];
  };
}
