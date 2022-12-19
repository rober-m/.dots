{ pkgs, inputs, system, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
    # Buffer tabs
      {
        plugin = galaxyline-nvim;
        type = "lua";
        config = ''
          ------------------------------------ GALAXYLINE -----------------------------------------
          TODO: Find out how to configure
          -- require("galaxyline.themes.eviline")
          ----------------------------------------------------------------------------------------- 
        '';
      }
    ];

    extraPackages = with pkgs; [
      vimPlugins.nvim-web-devicons
    ];

  };
}
