{
  pkgs,
  user,
  ...
}: let

  imports = [
    ../../common/home.nix # Common Home configuration
    # Start of NixOS specific configuration
    ./modules/zsh.nix
    ./modules/gtk.nix
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
    #neovim
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

}
