{pkgs, ...}: let
  imports = [
    #./gui/gtk.nix
    ./firefox.nix
    ./prisma-engines.nix
  ];
in {
  inherit imports;

  home.keyboard = null; # Configured at the system level.

  nixpkgs.overlays = [
    #(import ../../overlays/protonvpn-gui.nix)
  ];

  #-----------------------------------------------------------------------------#
  #---------------------------- Customized packages ----------------------------#

  # Most of these are in the `shared/home` config files.
  customized = {
    ssh.enable = true;
    git.enable = true;
    zsh.enable = true;
    tmux.enable = true;
    zellij.enable = true;
    neovim.enable = true;
    alacritty.enable = false;
    kitty.enable = true;
    vscode.enable = true;
    haskell.enable = true;
    prisma-engines.enable = false;
    firefox = {
      enable = true;
      withConfig = false;
    };
  };

  #-----------------------------------------------------------------------------#
  #-------------------------- Default-config packages --------------------------#

  home.packages = with pkgs;
    [
      protonvpn-gui # Proton VPN (broken temporarily in all Linux distros. Reverting to previous version by my-pkgs)
      bitwarden # Password manager
      bitwarden-cli # Bitwarden CLI
      #megasync # MegaSync (MEGA Cloud Drive) - Can alternatively be Installed using Flatpak or overlay
      telegram-desktop # Telegram for Linux
      #element-desktop # Element (Matrix) for Linux
      emote # emoji picker
      variety # Wallpaper manager
      #google-chrome # Google Chrome browser
      obsidian # Can't use it because of old Electron version :(
      # HLS 2.2.0 doesn't work in MacOS :(
      #haskell-language-server
      #(haskell-language-server.override {supportedGhcVersions = ["925" "928"];}) #Also installed in modules/nvim/lsp-config.nix
      cabal2nix # Cabal to Nix
      safeeyes # Eye-strain protection
      gnupg # GnuPG (Contains gpg and gpg-agent)
      pinentry # Pinentry is a collection of passphrase entry dialogs which is required for GPG
      cardano-pkgs.aiken # Aiken CLI
      thunderbird # Thunderbird email client
      anki # Flashcards

      code-cursor # Cursor IDE
      # Install Cursor as AppImage package (run `cursor` to start. No icon)
      #(pkgs.appimageTools.wrapType2 {
      #  name = "cursor";
      #  src = pkgs.fetchurl {
      #    url = "https://downloader.cursor.sh/linux/appImage/x64 ";
      #    sha256 = "sha256-CD6bQ4T8DhJidiOxNRgRDL4obfEZx7hnO0VotVb6lDc=";
      #  };
      #})

      todoist-electron

      #haskell.compiler.ghc925 #(GHC: 9.2.5  && base: 4.16.4.0)
      steam-run # Run commands in the same FHS environment that is used for Steam
    ]
    ++ [
      # TODO: dioxus stopped working after updating flake. Fix when needed
      #(pkgs.callPackage ../../../my-pkgs/my-dioxus-cli.nix {})
      #(pkgs.callPackage ../../../my-pkgs/my-protonvpn-gui.nix {})
    ];

  #-----------------------------------------------------------------------------#
  #-------------------------- Default-config programs --------------------------#

  programs.obs-studio.enable = true; # OBS Studio for screen recording

  #-----------------------------------------------------------------------------#
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
