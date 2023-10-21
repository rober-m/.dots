{pkgs, ...}: {
  # Configuration for darwin system and darwin-specific nix options.

  #################################################################################################
  ################################ DARWIN-SPECIFIC NIX CONFIG #####################################

  imports = [
    ../common/configuration.nix # Common all-systems configuration
    ./modules/homebrew.nix # Homebrew configuration
  ];

  nix.gc.interval = {
    Weekday = 0;
    Hour = 0;
    Minute = 0;
  }; # Run on the 0th day of the week at 00:00

  nix.configureBuildUsers = true; # TODO: should this be in common/configuration.nix?

  nix.settings = {
    auto-optimise-store = false; # See: https://github.com/NixOS/nix/issues/7273
    system = "x86_64-darwin";
    extra-platforms = ["x86_64-darwin" "aarch64-darwin"];
    experimental-features = ["nix-command" "flakes"];
    extra-sandbox-paths = [
      "/System/Library/Frameworks"
      "/System/Library/PrivateFrameworks"
      "/usr/lib"
      "/private/tmp"
      "/private/var/tmp"
      "/usr/bin/env"
    ];

    # --------------------- FOR OBELISK -----------------------
    #binary-caches-parallel-connections = 40;
    #sandbox = false;
    # ---------------------------------------------------------
  };

  #################################################################################################
  ################################### DARWIN (MacOS) CONFIG #######################################

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
  };

  #################################################################################################
  ####################################### OTHER CONFIG ############################################

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  programs = {
    # Create /etc/bashrc that loads the nix-darwin environment.
    zsh.enable = true;

    nix-index.enable = true;
  };

  # TODO: This looks like a bug waiting to hapen. Do I need this? Why?
  users = {
    users = {
      roberm = {
        home = "/Users/roberm";
      };
    };
  };

  # Fonts TODO: Extract to common
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      recursive
      (nerdfonts.override {fonts = ["Hack"];})
    ];
  };

  # Apps - TODO: Can I extract this to common and still have it work?
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    alacritty
    terminal-notifier
    #vscode
    flutter

    alejandra
  ];
}
