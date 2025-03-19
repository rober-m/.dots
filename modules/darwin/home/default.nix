{
  pkgs,
  user-options,
  ...
}: let
  imports = [
    ./custom-launcher.nix
    ./kanata-darwin.nix
  ];
in {
  inherit imports;

  home = {
    username = user-options.username;
    homeDirectory = "/Users/${user-options.username}";
  };

  #---------------------------- Customized packages ----------------------------#
  # Most of these are in the `shared/home` config files.
  customized = {
    ssh.enable = true;
    git.enable = true;
    zsh.enable = true;
    custom-launcher.enable = true;
    tmux.enable = true;
    neovim.enable = true;
    alacritty.enable = true;
    kitty.enable = true;
    vscode.enable = true;
    haskell.enable = true;
    kanata.enable = false; # Update flake to use new version
    superfile.enable = true;
  };

  #-------------------------- Default-config packages --------------------------#
  home.packages = with pkgs; [
    cocoapods
    m-cli # useful macOS CLI commands
    # INFO: Aiken CLI above v0.0.20-alpha doesn't compile on darwin. Using
    # alternative installations options
    #inputs.aiken_flake_20.packages.aarch64-darwin.aiken # Aiken CLI
    # darwin.xcode_14_1 # Nix can't install Xcode. Using App Store instead.
    #cardano-pkgs.aiken # Aiken CLI
    #haskell.compiler.ghc925 #(GHC: 9.2.5  && base: 4.16.4.0)
    zulu17 # Java 17 for Android development
  ];

  # ------------------------------ Misc configuration files ---------------------------------------

  home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
}
