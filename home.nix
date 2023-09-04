{
  pkgs,
  lib,
  ...
}: let
  imports = [
    ./modules/neovim
    ./modules/alacritty
    ./modules/custom-launcher.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/ssh.nix
    ./modules/haskell.nix # Haskell-related binaries and config (withot nvim config)
    #./modules/vscode/vscode.nix # TODO: Try this config when I have time to fix it in case it breaks VSCode containers
    #./modules/yabairc.nix
  ];
in {
  inherit imports;

  home = {
    stateVersion = "22.05";
    username = "roberm";
    homeDirectory = "/Users/roberm";
  };

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs = {
    #vscode.enable = true;
    ssh.enable = false;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    htop = {
      enable = true;
      settings.show_program_path = true;
    };
  };

  home.packages = with pkgs;
    [
      # Terminal
      coreutils
      curl
      wget
      git
      dua # Disk Usage Analyzer
      lazygit # Also installed in modules/nvim
      zsh
      lsd
      bat
      fd
      fzf
      jq
      zoxide # Also installed in modules/nvim
      mdbook # Create books from Markdown
      inetutils # Collection of common network programs: ping6, telnet, ifconfig, whois, etc
      #graphviz-nox # Graph visualization software (I use it to compile *.dot files. See: https://graphviz.org/doc/info/lang.html)
      #texlive.combined.scheme-full # LaTeX (I use it to compile Andres' slides) TODO: Delete if not needed, it's a big package.

      # Communications
      discord
      slack
      # telegram

      # Python and Jupyter
      python310Packages.pip
      python310Packages.jupyter
      python310Packages.jupyter_core
      python310Packages.jupyter-client
      python310Packages.jupyterlab
      python310Packages.notebook

      # NodeJS stuff
      nodejs
      nodePackages.typescript
      nodePackages.node2nix
      nodePackages.web-ext # cli to help build web extensions
      nodePackages.firebase-tools # firebase CLI

      # Nix stuff
      cachix # adding/managing alternative binary caches hosted by Cachix
      comma # run software from without installing it
      niv # easy dependency management for nix projects
      nix-tree # visualize the dependency graph of a nix derivation

      #Rust
      rustup

      # Other
      docker
    ]
    ++ lib.optionals stdenv.isDarwin [
      cocoapods
      m-cli # useful macOS CLI commands
      karabiner-elements
    ];

  # Misc configuration files --------------------------------------------------------------------{{{

  # TODO: Only run if it's on a Darwin system
  home.file.".config/karabiner/karabiner.json".source = ./modules/karabiner.json;
  #home.file."karabiner/karabiner.json" = builtins.readFile ./modules/karabiner.json;
}
