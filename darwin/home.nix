{
  pkgs,
  user-options,
  ...
}: let
  imports = [
    ../common/home.nix # Common Home configuration
    # Start of the macOS specific configuration
    ./modules/zsh.nix
    ./modules/ssh.nix
    ./modules/custom-launcher.nix
  ];
in {
  inherit imports;

  home = {
    username = user-options.username;
    homeDirectory = "/Users/${user-options.username}";
  };

  home.packages = with pkgs; [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

  home.file.".config/karabiner/karabiner.json".source = ./modules/karabiner.json;
}
