{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Buffer tabs
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = builtins.readFile ./bufferline.lua;
      }
    ];
  };
}
