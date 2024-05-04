{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = ChatGPT-nvim;
        type = "lua";
        config = builtins.readFile ./chatGPT.lua;
      }
    ];

    extraPackages = with pkgs; [
      bitwarden-cli # To provide OpenAI API key
    ];
  };
}
