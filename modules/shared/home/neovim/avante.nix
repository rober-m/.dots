{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = avante-nvim;
        type = "lua";
        config = builtins.readFile ./avante.lua;
      }
    ];
  };
}
