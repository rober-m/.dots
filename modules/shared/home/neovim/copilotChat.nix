{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = CopilotChat-nvim;
        type = "lua";
        config = builtins.readFile ./copilotChat.lua;
      }
    ];

    extraPackages = with pkgs.vimPlugins; [
      copilot-vim # GitHub Copilot
      plenary-nvim # Lua functions that many plugins depend on
    ];
  };
}
