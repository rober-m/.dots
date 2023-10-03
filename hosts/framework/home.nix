{
  pkgs,
  user,
  ...
}: let
  imports = [
    ../../common/home.nix # Common Home configuration
    # Start of NixOS specific configuration
    ./modules/zsh.nix
  ];
in {
  inherit imports;

 # home = {
 #   username = user;
 #   homeDirectory = "/Users/${user}";
 # };

  home.packages = with pkgs; [
    protonvpn-gui
    bitwarden
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

}
