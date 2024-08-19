{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Tree file explorer.
      # DOCS: https://github.com/nvim-tree/nvim-tree.lua/
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./nvim-tree.lua;
      }
    ];

    extraPackages = with pkgs; [
      vimPlugins.nvim-web-devicons
    ];
  };
}
