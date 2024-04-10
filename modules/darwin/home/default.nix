{
  pkgs,
  user-options,
  inputs,
  ...
}: let
  imports = [
    ./custom-launcher.nix
  ];
in {
  inherit imports;

  home = {
    username = user-options.username;
    homeDirectory = "/Users/${user-options.username}";
  };

  #---------------------------- Customized packages ----------------------------#
  customized = {
    ssh.enable = true;
    zsh.enable = true;
    custom-launcher.enable = true;
    tmux.enable = true;
    neovim.enable = true;
    alacritty.enable = false;
    vscode.enable = true;
  };

  #-------------------------- Default-config packages --------------------------#
  home.packages = with pkgs; [
    cocoapods
    m-cli # useful macOS CLI commands
    # INFO: Aiken CLI above v0.0.20-alpha doesn't compile on darwin. Using `nix profile` for now
    inputs.aiken_flake_20.packages.aarch64-darwin.aiken # Aiken CLI
  ];

  # ------------------------------ Misc configuration files ---------------------------------------

  home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
}
