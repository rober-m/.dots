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

  homebrew.enable = true;
  homebrew.caskArgs = {
    appdir = "~/Applications";
    require_sha = true;
  };
  homebrew.casks = [
    "google-chrome"
    "telegram-desktop"
    "obs"
    "obsidian"
    "notion"
    "amethyst"
  ];

 # services.yabai = {
 #   enable = true;
 #   package = pkgs.yabai;
 #   config = {
 #     top_padding         = 60;
 #     bottom_padding      = 10;
 #     left_padding        = 10;
 #     right_padding       = 10;
 #     window_gap          = 10;
 #     window_opacity      = "on";
 #     active_window_opacity = 1.0;
 #     normal_window_opacity = 0.85;
 #     window_shadow         = "off";
 #     window_topmost        = "on";
 #     focus_follows_mouse   = "autoraize";
 #     mouse_follows_focus   = "on";
 #     split_ratio           = 0.5;
 #   };
 #   extraConfig = ''
 #     yabai -m rule --add app='System Preferences' manage=off
 #   '';
 # };

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

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

}
