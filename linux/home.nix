{pkgs, ...}: let
  imports = [
    ../common/home.nix # Common Home configuration
    # Start of Linux specific configuration
    ./modules/zsh.nix
    #./modules/gui/gtk.nix
    #./modules/vscode-linux.nix
    #./modules/firefox.nix
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
    megasync # MegaSync (MEGA Cloud Drive)
    telegram-desktop # Telegram for Linux
    emote # emoji picker
    variety # Wallpaper manager
    #google-chrome # Google Chrome browser
    firefox # Firefox browser
    obsidian # Can't use it because of old Electron version :(
    # HLS 2.2.0 doesn't work in MacOS :(
    haskell-language-server
    #(haskell-language-server.override {supportedGhcVersions = ["925" "928"];}) #Also installed in modules/nvim/lsp-config.nix
  ];

  home.file.".config/rofi/config.rasi".source = ./modules/gui/wayland/config.rasi;
  home.file.".config/hypr/hyprland.conf".source = ./modules/gui/wayland/hyprland/hyprland.conf;
  home.file.".config/hypr/start.sh" = {
    source = ./modules/gui/wayland/hyprland/start.sh;
    executable = true;
  };
}
