{
  pkgs,
  user-options,
  ...
}: {
  imports = [
    ./homebrew.nix # Homebrew packages and configuration
    ./nix.nix # Darwin-specific Nix configuration
  ];

  #------------------------------------------------------------------------------------------------
  #---------------------------------- DARWIN (MacOS) CONFIG ---------------------------------------

  # TODO: Use .dots/wallpapers folder to set wallpapers and make them autoroate every day.

  system = {
    # Dock
    defaults.dock = {
      autohide = true; # Autohide dock
      orientation = "bottom"; # Were the Dock is located. "left", "bottom", "right"
      mru-spaces = false; # Whether to automatically rearrange spaces based on most recent use.
      wvous-tl-corner = 1; # Hot corner action for top left corner. 1 = Mission Control.
      wvous-tr-corner = 1; # Hot corner action for top right corner. 1 = Mission Control.
      wvous-bl-corner = 11; # Hot corner action for bottom left corner. 11 = Launchpad.
      wvous-br-corner = 11; # Hot corner action for bottom right corner. 11 = Launchpad.
    };
    # Keyboard
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    # Finder
    defaults.finder = {
      AppleShowAllExtensions = true;
    };
    # Trackpad
    defaults.trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = false;
    };
    # Global
    defaults.NSGlobalDomain = {
      AppleShowAllExtensions = true; # Show all file extensions
      AppleShowAllFiles = true; # Show hidden files in Finder
      AppleShowScrollBars = "WhenScrolling"; # Show scrollbars when scrolling
      "com.apple.mouse.tapBehavior" = 1; # Mode 1 enables tap to click
      NSAutomaticWindowAnimationsEnabled = false; # Animate opening and closing of windows and popovers.
      "com.apple.swipescrolldirection" = false; # Scroll direction: true = natural, false = regular
      ApplePressAndHoldEnabled = false; # Disable press-and-hold for keys in favor of key repeat.
      #"com.microsoft.VSCode ApplePressAndHoldEnabled" = false; # Disable press-and-hold for keys in favor of key repeat. # TODO: Delete this if global one works after restarting
    };
    # Software updates
    defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    stateVersion = 4;
  };

  #------------------------------------------------------------------------------------------------
  #-------------------------------------- OTHER CONFIG --------------------------------------------

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  services.karabiner-elements.enable = true;

  programs = {
    # Create /etc/bashrc that loads the nix-darwin environment.
    zsh.enable = true;

    nix-index.enable = true;
  };

  # TODO: This looks like a bug waiting to hapen. Do I need this? Why?
  users = {
    users = {
      roberm = {
        home = "/Users/${user-options.username}";
      };
    };
  };

  # Apps - TODO: Can I extract this to common and still have it work?
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    alacritty
    terminal-notifier
    alejandra
  ];
}
