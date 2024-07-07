{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # INFO: I had to install hoogle separatedly "extraPackages" didn't work.
      {
        plugin = haskell-tools-nvim;
        type = "lua";
        config = builtins.readFile ./haskell.lua;
      }
    ];

    # extraPackages = with pkgs; [
    #   vimPlugins.plenary-nvim
    #   haskellPackages.hoogle
    # ];
  };
}
