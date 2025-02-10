{
  pkgs,
  user-options,
  lib,
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
  };

  #-------------------------- Default-config packages --------------------------#
  home.packages = with pkgs; [
    cocoapods
    #kanata # Keyboard remap layouts. It's broken on the latest version (1.7-1). Wait for PR to be merged: https://github.com/NixOS/nixpkgs/pull/334243
    (pkgs.callPackage ../../../my-pkgs/my-kanata.nix {}) # The installer works, but kanata doesn't. TODO: Create an issue.
    m-cli # useful macOS CLI commands
    # INFO: Aiken CLI above v0.0.20-alpha doesn't compile on darwin. Using
    # alternative installations options
    #inputs.aiken_flake_20.packages.aarch64-darwin.aiken # Aiken CLI
    # darwin.xcode_14_1 # Nix can't install Xcode. Using App Store instead.
    #cardano-pkgs.aiken # Aiken CLI
    #haskell.compiler.ghc925 #(GHC: 9.2.5  && base: 4.16.4.0)
  ];

  # ------------------------------ Misc configuration files ---------------------------------------

  home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
  home.file.".config/kanata/kanata.kbd".text =
    /*
    lisp
    */
    ''
      ;; defsrc is still necessary
      (defcfg
        process-unmapped-keys yes
      )

      (defsrc
        a s d f j k l ;
      )
      (defvar
        tap-time 150
        hold-time 200
      )

      (defalias
        a (tap-hold $tap-time $hold-time a lmet)
        s (tap-hold $tap-time $hold-time s lalt)
        d (tap-hold $tap-time $hold-time d lsft)
        f (tap-hold $tap-time $hold-time f lctl)
        j (tap-hold $tap-time $hold-time j rctl)
        k (tap-hold $tap-time $hold-time k rsft)
        l (tap-hold $tap-time $hold-time l ralt)
        ; (tap-hold $tap-time $hold-time ; rmet)
      )

      (deflayer base
        @a @s @d @f @j @k @l @;
      )
    '';
}
