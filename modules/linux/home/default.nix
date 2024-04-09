{
  pkgs,
  inputs,
  ...
}: let
  imports = [
    #./gui/gtk.nix
    #./vscode-linux.nix
    #./firefox.nix
    ./ssh.nix
    ./prisma-engines.nix
  ];
in {
  inherit imports;

  home.keyboard = null; # Configured at the system level.

  #---------------------------- Customized packages ----------------------------#
  customized = {
    zsh.enable = true;
    tmux.enable = true;
    neovim.enable = true;
    alacritty.enable = false;
  };
  #-------------------------- Default-config packages --------------------------#
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
    safeeyes # Eye-strain protection

    gnupg # GnuPG (Contains gpg and gpg-agent)
    pinentry # Pinentry is a collection of passphrase entry dialogs which is required for GPG

    inputs.aiken_flake.packages.x86_64-linux.aiken # Aiken CLI
  ];
  #-------------------------- Default-config programs --------------------------#
  programs.obs-studio.enable = true; # OBS Studio for screen recording
  #----------------------------- Other config files ----------------------------#
  # TODO: Move these config files to the hyprland module
  home.file.".config/rofi/config.rasi".source = ../nixos/gui/wayland/rofi/config.rasi;
  home.file.".config/hypr/hyprland.conf".source = ../nixos/gui/wayland/hyprland/hyprland.conf;
  home.file.".config/hypr/start.sh" = {
    source = ../nixos/gui/wayland/hyprland/start.sh;
    executable = true;
  };
  home.file = {
    ".config/waybar/" = {
      source = ../nixos/gui/wayland/waybar;
      recursive = true;
    };
  };
}
