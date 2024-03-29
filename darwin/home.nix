{
  pkgs,
  user-options,
  inputs,
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

  custom_tmux.enable = true;
  custom_neovim.enable = true;
  custom_alacritty.enable = true;

  home = {
    username = user-options.username;
    homeDirectory = "/Users/${user-options.username}";
  };

  home.packages = with pkgs; [
    cocoapods
    m-cli # useful macOS CLI commands
    inputs.aiken_flake.packages.aarch64-darwin.aiken # Aiken CLI
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

  home.file.".config/karabiner/karabiner.json".source = ./modules/karabiner.json;
}
