{ config, pkgs, lib, ... }:

{
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

  #programs.neovim.enable = true;
  #programs.neovim.vimAlias = true;
  #programs.neovim.viAlias = true;
  #programs.nixvim.enable = true;
  
  programs.git = {
    enable = true;
    userName = "Robertino Martinez";
    userEmail = "48034748+rober-m@users.noreply.github.com";
    aliases = {
      s = "status";
      co = "checkout";
      aa = "add .";
      cm = "commit -m";
      ca = "commt --amend --no-edit";
    };
    difftastic.enable = true;
  };

  programs.vscode.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    # localVariables = {};
    shellAliases = {
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -la";
      rebuild = "darwin-rebuild switch --flake ~/.config#roberm";
      v = "lvim";
      cat = "bat";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.95;
      font = {
        size = 14;
        normal.family = "Hack Nerd Font";
      };
      draw_bold_text_with_bright_colors = true;
      cursor = {
        style.shape = "Block";
        blinking = "Off";
      };
      key_bindings = [
        #{ key = ""; mods = ""; chars/action = ""; }
        { key = "N"; mods = "Command"; action = "SpawnNewInstance"; }
      ];
    };
  };

  home.packages = with pkgs; [
    # Some basics
    coreutils
    curl
    wget

    # TERMINAL
    #dua-cli
    lazygit
    zsh
    lsd
    bat


    # Dev stuff
    # (agda.withPackages (p: [ p.standard-library ]))
    #google-cloud-sdk
    haskellPackages.cabal-install
    #haskellPackages.hoogle
    #haskellPackages.hpack
    haskellPackages.implicit-hie
    haskellPackages.stack
    idris2
    jq
    nodePackages.typescript
    nodejs

    # Useful nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    niv # easy dependency management for nix projects
    nodePackages.node2nix

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

  # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
  home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
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

}
