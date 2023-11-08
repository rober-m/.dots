{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = ChatGPT-nvim;
        type = "lua";
        config = builtins.readFile ./chatGPT.lua;
      }
    ];
  };
}
