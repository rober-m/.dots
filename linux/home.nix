{pkgs, ...}: let
  imports = [
    ../common/home.nix # Common Home configuration
    # Start of Linux specific configuration
    ./modules/zsh.nix
    #./modules/gui/gtk.nix
    #./modules/vscode-linux.nix
    ./modules/firefox.nix
    ./modules/ssh.nix
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
    #megasync # MegaSync (MEGA Cloud Drive) # TODO: Check if this was solved: https://github.com/NixOS/nixpkgs/issues/126848
    telegram-desktop # Telegram for Linux
    emote # emoji picker
    variety # Wallpaper manager
    google-chrome # Google Chrome browser
    # HLS 2.2.0 doesn't work in MacOS :(
    (haskell-language-server.override {supportedGhcVersions = ["810" "925" "928"];}) #Also installed in modules/nvim/lsp-config.nix
  ];
}
