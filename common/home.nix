{pkgs, user, ...}: let
  imports = [
    ./modules
  ];
in {
  inherit imports;

  home.stateVersion = "22.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix
  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs = {
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


  fonts.fontconfig.enable = true;


  home.packages = with pkgs; [

    # Terminal
    (pkgs.nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
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
    docker-compose

    # Desktop Rice
    neofetch # Print system properties
    variety # Wallpaper manager

    # Communications
    #discord
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
    google-chrome
  ];
}
