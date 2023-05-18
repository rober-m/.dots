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

  home.stateVersion = "22.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.vscode.enable = true;

  programs.ssh = {
    enable = false;
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

    # Communications
    discord
    slack
    # telegram

    # Python and Jupyter 
    python39Packages.jupyter
    python39Packages.jupyter_core
    python39Packages.jupyter-client
    python39Packages.jupyterlab
    python39Packages.notebook

    # Haskell stuff
    ghc
    haskell-language-server # Also installed in modules/nvim/lsp-config.nix
    haskellPackages.cabal-install
    haskellPackages.hoogle
    #haskellPackages.hpack
    #haskellPackages.implicit-hie
    #haskellPackages.stack
    haskellPackages.ihaskell
    #haskellPackages.ghcup

    # Web stuff
    nodejs
    nodePackages.typescript
    nodePackages.node2nix
    nodePackages.web-ext # cli to help build web extensions

    # Nix stuff
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    niv # easy dependency management for nix projects

    #Rust
    rustup

    # Other
    docker

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
