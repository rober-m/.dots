# Docs:
# - https://nixos.wiki/wiki/XMonad
# TODO: Create a project around xmonad.hs (See las section of previous link)
{ ... }:
{
  services.xserver.windowManager.xmonad = {
    enable = true;
    config = builtins.readFile ./xmonad.hs;

    # Adds the xmonad-contrib and xmonad-extras packages
    # https://hackage.haskell.org/package/xmonad-contrib
    enableContribAndExtras = true; 

    # When developing modules for XMonad, it can help to install the following packages: 
    extraPackages = haskellPackages: [
      haskellPackages.dbus
      haskellPackages.List
      haskellPackages.monad-logger
    ];

    ghcArgs = [
      "-hidir /tmp" # place interface files in /tmp, otherwise ghc tries to write them to the nix store
      "-odir /tmp" # place object files in /tmp, otherwise ghc tries to write them to the nix store

      # To add Haskell modules that are not included in the Xmonad-Contrib package, you have to tell ghc where to find them.
      #"-i${xmonad-contexts (only an example)}" # tell ghc to search in the respective nix store path for the module
    ];
  };
}
