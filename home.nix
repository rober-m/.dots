{ pkgs, lib, ... }:
let
  imports = [
    ./modules/neovim
    ./modules/alacritty
    ./modules/custom-launcher.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/ssh.nix
    #./modules/yabairc.nix
  ];
in
{

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
    htop ={
      enable = true;
      settings.show_program_path = true;
    };
  };

  home.packages = with pkgs; [

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
    nix-tree
    mdbook # Create books from Markdown
    inetutils # Collection of common network programs: ping6, telnet, ifconfig, whois, etc

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

    # Haskell stuff
    # GHC VS boot libraries version: https://gitlab.haskell.org/ghc/ghc/-/wikis/commentary/libraries/version-history
    #haskell.compiler.ghc810 #(GHC: 8.10.7 && base: 4.14.3.0)
    haskell.compiler.ghc925  #(GHC: 9.2.5  && base: 4.16.4.0)
    #haskell.compiler.ghc928 #(GHC: 9.2.6  && base: 4.16.4.0)
    #haskell.compiler.ghc942 #(GHC: 9.4.2  && base: 4.17.0.0)
    #haskell.compiler.ghc96  #(GHC: 9.6.2  && base: 4.18.0.0)
    (haskell-language-server.override { supportedGhcVersions = [ "925" "928" ]; })  #Also installed in modules/nvim/lsp-config.nix
    haskellPackages.cabal-install
    haskellPackages.hoogle
    haskellPackages.ihaskell
    ihp-new # IHP framework (https://ihp.digitallyinduced.com/Guide/index.html)
    haskellPackages.doctest

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

    #Rust
    rustup

    # Other
    docker
    #vscode

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
    karabiner-elements
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

  # TODO: Only run if it's on a Darwin system
  home.file.".config/karabiner/karabiner.json".source = ./modules/karabiner.json;
  #home.file."karabiner/karabiner.json" = builtins.readFile ./modules/karabiner.json;

  # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
  home.file.".stack/config.yaml".text = lib.generators.toYAML { } {
    templates = {
      scm-init = "git";
      params = {
        author-name = "Robertino Martinez"; # config.programs.git.userName;
        author-email = "48034748+rober-m@users.noreply.github.com"; # config.programs.git.userEmail;
        github-username = "rober-m";
      };
    };
    nix.enable = true;
  };

  home.file.ghc = {
    target = ".ghci";
    text = ''
      :set prompt "λ: "
    '';
  };

}
