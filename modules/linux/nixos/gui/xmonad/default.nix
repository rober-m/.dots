# DOCS:
# - https://nixos.wiki/wiki/XMonad
# TODO: Create a project around xmonad.hs (See las section of previous link)
{pkgs, ...}: {
  # Suspend system after inactivity
  # Xmonad is a Window Manager (WM) and not a Desktop Environment (DE).
  # Therefore, among other things, Xmonad does not handle power management related things such as sleeping.
  # However, there are several ways of still adding this functionality.
  services.xserver.displayManager.sessionCommands = ''
    xset -dpms  # Disable Energy Star, as we are going to suspend anyway and it may hide "success" on that
    xset s blank # `noblank` may be useful for debugging
    xset s 300 # seconds
    ${pkgs.lightlocker}/bin/light-locker --idle-hint &
  '';

  # The settings above will toggle the flag "IdleHint" within logind through light-locker (will work with "'lightdm'", there are alternatives). Next we'll have to pick-up the information within logindand select an action to take:
  # The configuration below will let the system go to "hybrid-sleep" `20s` after the screen-saver triggered
  systemd.targets.hybrid-sleep.enable = true;
  services.logind.extraConfig = ''
    IdleAction=hybrid-sleep
    IdleActionSec=20s
  '';

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
