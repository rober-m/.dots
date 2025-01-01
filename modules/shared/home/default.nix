{
  pkgs,
  inputs,
  user-options,
  ...
}: let
  #---------------------------- Customized packages ----------------------------#
  imports = [
    ./ssh.nix
    ./neovim
    ./alacritty
    ./kitty.nix
    ./tmux
    ./git.nix
    ./zsh.nix
    ./haskell.nix # Haskell-related binaries and config (withot nvim config)
    ./vscode
    inputs.nix-colors.homeManagerModules.default
  ];
in {
  inherit imports;

  # TODO: Does this make sense? What about linux desktop vs server?:
  # Don't enable/disable customized options here. This file serves only as a
  # configuration aggregator. Enable/disable your custom options in the
  # respective modules (linux/home, darwin/home).

  home.stateVersion = "22.05";
  colorScheme = inputs.nix-colors.colorSchemes.${user-options.colorscheme};
  fonts.fontconfig.enable = true;

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix
  # Direnv, load and unload environment variables depending on the current directory.
  #-------------------------- Default-config programs --------------------------#
  programs = {
    # DOCS: https://direnv.net
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    htop = {
      enable = true;
      settings.show_program_path = true;
    };
  };
  #-------------------------- Default-config packages --------------------------#
  home.packages = with pkgs; [
    # Generic Terminal
    (pkgs.nerdfonts.override {fonts = user-options.fonts;})
    coreutils
    curl
    wget
    git
    gh # GitHub CLI
    gitleaks # Git leaks detector CLI
    lazygit # Also installed in modules/nvim
    dua # Disk Usage Analyzer
    zsh # Linux shell
    lsd
    bat # `cat` with wings
    fd # Simplified `find`
    ripgrep # Fast `grep`
    fzf # Fuzzy finder
    jq # JSON processor
    jless # JSON CLI interactive viewer
    zoxide # Also installed in modules/nvim
    mdbook # Create books from Markdown
    inetutils # Collection of common network programs: ping6, telnet, ifconfig, whois, etc
    tree # Print folder structure as a tree
    eza # Easy aliases for zsh
    btop # Resource monitor (htop wiht steroids)
    zlib # Compression library. Needed to use Haskell's zlib package
    watchman # File watching service
    cmake # Cross-platform build system

    # Virtualization
    lazydocker # Lazygit for Docker
    docker
    docker-compose

    neofetch # Print system properties

    # Communications
    discord
    slack
    # telegram

    # Python and Jupyter
    #python310Packages.pip
    #python310Packages.jupyter
    #python310Packages.jupyter_core
    #python310Packages.jupyter-client
    #python310Packages.jupyterlab
    #python310Packages.notebook

    # WebDev stuff
    deno
    nodejs
    yarn
    nodePackages.typescript
    nodePackages.node2nix
    nodePackages.web-ext # cli to help build web extensions
    #nodePackages.firebase-tools # firebase CLI (Installed trhough npm because nixpkgs' version is outdated)
    #nodePackages.vercel # Vercel CLI

    # Nix stuff
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    niv # easy dependency management for nix projects
    nix-tree # visualize the dependency graph of a nix derivation
    alejandra # Nix code formatter
    nix-init # Command line tool to generate Nix packages from URLs
    nix-output-monitor # Use `nom <build|develop|shell>` to show aditional information while building

    #Rust
    #gcc # GNU Compiler Collection
    rustup # Rust toolchain installer (using this to install rust tooling)

    # Flutter
    #flutter

    # Other
    #anki # Flashcards
    #elmPackages.elm
    typst # LaTeX alternative
    #typst-lsp # Typst language server
    #bitwarden-cli # Bitwarden CLI
    ollama

    shellcheck # Shell script analysis tool (Run shellcheck <script>)
    #neovide # Neovim GUI
    #agda (not for now)
    stripe-cli # CLI to test Stripe integrations
  ];
  #----------------------------- Other config files ----------------------------#
  home.file.".config/neofetch/config.conf".source = ./neofetch.conf;
}
