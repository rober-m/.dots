{
  pkgs,
  inputs,
  ...
}: let
  imports = [
    ../common/home.nix # Common Home configuration
    # Start of Linux specific configuration
    ./modules/zsh.nix
    #./modules/gui/gtk.nix
    #./modules/vscode-linux.nix
    #./modules/firefox.nix
    ./modules/ssh.nix
    ./modules/prisma-engines.nix
  ];
in {
  inherit imports;

  custom_tmux.enable = true;
  custom_neovim.enable = true;
  custom_alacritty.enable = true;

  home.keyboard = null; # Configured in `configuration.nix`.

  home.packages = with pkgs; [
    protonvpn-gui # Proton VPN
    bitwarden # Password manager
    #megasync # MegaSync (MEGA Cloud Drive) - Installed using Flatpak
    telegram-desktop # Telegram for Linux
    #element-desktop # Element (Matrix) for Linux
    emote # emoji picker
    variety # Wallpaper manager
    #google-chrome # Google Chrome browser
    firefox # Firefox browser
    obsidian # Can't use it because of old Electron version :(
    # HLS 2.2.0 doesn't work in MacOS :(
    #haskell-language-server
    #(haskell-language-server.override {supportedGhcVersions = ["925" "928"];}) #Also installed in modules/nvim/lsp-config.nix
    cabal2nix # Cabal to Nix

    gnupg # GnuPG (Contains gpg and gpg-agent)
    pinentry # Pinentry is a collection of passphrase entry dialogs which is required for GPG

    inputs.aiken_flake.packages.x86_64-linux.aiken # Aiken CLI
  ];

  # TODO: Move these config files to the hyprland module
  home.file.".config/rofi/config.rasi".source = ./modules/gui/wayland/rofi/config.rasi;
  home.file.".config/hypr/hyprland.conf".source = ./modules/gui/wayland/hyprland/hyprland.conf;
  home.file.".config/hypr/start.sh" = {
    source = ./modules/gui/wayland/hyprland/start.sh;
    executable = true;
  };
  home.file = {
    ".config/waybar/" = {
      source = ./modules/gui/wayland/waybar;
      recursive = true;
    };
  };
}
