{
  pkgs,
  user,
  ...
}: let
  imports = [
    ../common/home.nix # Common Home configuration
    # Start of the macOS specific configuration
    ./modules/zsh.nix
    ./modules/custom-launcher.nix
  ];
in {
  inherit imports;

  home = {
    username = user;
    homeDirectory = "/Users/${user}";
  };

  home.packages = with pkgs; [
    cocoapods
    m-cli # useful macOS CLI commands
    karabiner-elements
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

  home.file.".config/karabiner/karabiner.json".source = ./modules/karabiner.json;
  #home.file."karabiner/karabiner.json" = builtins.readFile ./modules/karabiner.json;
}
