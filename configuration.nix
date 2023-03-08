{ pkgs, lib, ... }:
{
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [
    "https://cache.nixos.org/" # Default NixOS cache
    "https://nixcache.reflex-frp.org" # Obelisk cache
    "https://cache.iog.io" # IOG (IOHK) cache
    "https://cache.zw3rk.com" # zw3kr (Moritz Angermann) cache
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Default NixOS cache key
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" # Obelisk cache key
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" # IOG (IOHK) cache key
    "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk=" # zw3kr (Moritz Angermann) cache key
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];

  nix.configureBuildUsers = true;

  environment.variables.EDITOR = "nvim";

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = false # See: https://github.com/NixOS/nix/issues/7273
    experimental-features = nix-command flakes
    ####  FOR OBELISK ######
    #binary-caches-parallel-connections = 40 # Obelisk
    #sandbox = false # Obelisk
    ########################
    system = x86_64-darwin
    extra-platforms = x86_64-darwin aarch64-darwin
    extra-sandbox-paths = /System/Library/Frameworks /System/Library/PrivateFrameworks /usr/lib /private/tmp /private/var/tmp /usr/bin/env
    experimental-features = nix-command
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      #"yabai"

      # To build IHaskell from source
      "zeromq"
      "libmagic"
      "cairo"
      "pkg-config"
      "haskell-stack"
      "pango"
    ];
    taps = [
      "homebrew/cask"
      "koekeishiya/formulae" # yabai
      #"microsoft/git" # git-credential-manager-core
    ];
    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
    casks = [
      "google-chrome"
      "telegram-desktop"
      "obs"
      "obsidian"
      "notion"
      "amethyst"
      #"git-credential-manager-core"


    ];
  };

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    alacritty
    exa
    terminal-notifier
  ];

  programs.nix-index.enable = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  system = {
    # Dock
    defaults.dock = {
      autohide = true; # Autohide dock
      orientation = "left"; # Were the Dock is
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
      TrackpadThreeFingerDrag = true;
    };
    # Global
    defaults.NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      "com.apple.mouse.tapBehavior" = 1; # Mode 1 enables tap to click
      NSAutomaticWindowAnimationsEnabled = false; # Animate opening and closing of windows and popovers.
    };
    # Software updates
    defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

}
