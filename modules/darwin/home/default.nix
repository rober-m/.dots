{
  pkgs,
  user-options,
  inputs,
  ...
}: let
  imports = [
    ./zsh.nix
    ./ssh.nix
    ./custom-launcher.nix
  ];
in {
  inherit imports;

  customized = {
    zsh.enable = true;
    ssh.enable = true;
    custom-launcher.enable = true;
  };

  home = {
    username = user-options.username;
    homeDirectory = "/Users/${user-options.username}";
  };

  home.packages = with pkgs; [
    cocoapods
    m-cli # useful macOS CLI commands
    # INFO: Aiken CLI above v0.0.20-alpha doesn't compile on darwin. Using `nix profile` for now
    inputs.aiken_flake_20.packages.aarch64-darwin.aiken # Aiken CLI
  ];

  # ------------------------------ Misc configuration files ---------------------------------------

  home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
}
