{pkgs, ...}: let
  imports = [
    ../common/home.nix # Common Home configuration
    # Start of Linux specific configuration
    ./modules/zsh.nix
    #./modules/gui/gtk.nix
    ./modules/vscode-linux.nix
    ./modules/firefox.nix
  ];
in {
  inherit imports;

  # home = {
  #   username = user;
  #   homeDirectory = "/Users/${user}";
  # };

  home.keyboard = null; # Configured in `configuration.nix`.

  home.packages = with pkgs; [
    protonvpn-gui # Proton VPN
    bitwarden # Password manager
    megasync # MegaSync (MEGA Cloud Drive)
    telegram-desktop # Telegram for Linux
    emote # emoji picker
    variety # Wallpaper manager
    google-chrome # Google Chrome browser
  ];
}
