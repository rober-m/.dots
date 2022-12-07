{ pkgs, lib, ... }:
{
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];

  nix.configureBuildUsers = true;
  
  environment.variables.EDITOR = "nvim";

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
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
    ];
    taps = [
      "homebrew/cask"
      "koekeishiya/formulae" # yabai
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
      autohide = true;
      orientation = "left";
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
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

}
