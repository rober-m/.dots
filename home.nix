{ config, pkgs, lib, ... }:
let 
  imports = [
    ./modules/neovim
    ./modules/alacritty
    ./modules/custom-launcher.nix
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
    extraConfig = {
      github.user = "rober-m";
      pull.rebase = false;
      merge.conflictstyle = "diff3";
      #credential.helper = "osxkeychain";
    };
  };

  programs.vscode.enable = true;

  programs.ssh = {
    enable = false;
  };

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
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" 
    '';
    sessionVariables = {
     HOMEBREW_NO_ANALYTICS = 1;
    };
  };

  home.packages = with pkgs; [

    # Terminal
    coreutils
    curl
    wget
    git
    dua
    lazygit
    zsh
    lsd
    bat
    fd
    fzf
    jq

    # Work
    discord
    slack
    
    # Python and Jupyter 
    python39Packages.jupyter
    python39Packages.jupyter_core
    python39Packages.jupyter-client
    python39Packages.jupyterlab
    python39Packages.notebook

    # Haskell stuff
    ghc
    haskell-language-server
    haskellPackages.cabal-install
    #haskellPackages.hoogle
    #haskellPackages.hpack
    #haskellPackages.implicit-hie
    #haskellPackages.stack
    haskellPackages.ihaskell

    # Web stuff
    nodejs
    nodePackages.typescript
    nodePackages.node2nix

    # Nix stuff
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    niv # easy dependency management for nix projects

    # Other
    docker

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


  home.file.ghc = {
    target = ".ghci";
    text = ''
      :set prompt "λ: "
    '';
  };


  # Configure properly if I have the time
  home.file.yabai = {
  executable = true;
  target = ".config/yabai/yabairc";
  text = ''
    #!/usr/bin/env sh
    # load scripting addition
    sudo yabai --load-sa
    yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
    # bar configuration
    yabai -m config external_bar all:0:39
    yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
    # borders
    yabai -m config window_border on
    yabai -m config window_border_width 2
    yabai -m config window_border_radius 6
    yabai -m config window_border_blur off
    yabai -m config active_window_border_color 0xFF40FF00
    yabai -m config normal_window_border_color 0x00FFFFFF
    yabai -m config insert_feedback_color 0xffd75f5f
    yabai -m config window_shadow off
    # layout
    yabai -m config layout bsp
    yabai -m config auto_balance off
    yabai -m config window_topmost on
    # gaps
    yabai -m config top_padding    0
    yabai -m config bottom_padding 0
    yabai -m config left_padding   0
    yabai -m config right_padding  0
    yabai -m config window_gap     0
    # rules
    yabai -m rule --add app="^System Preferences$" manage=off
    # workspace management
    yabai -m space 1 --label term
    yabai -m space 2 --label code
    yabai -m space 3 --label www
    yabai -m space 4 --label chat
    yabai -m space 5 --label todo
    yabai -m space 6 --label music
    yabai -m space 7 --label seven
    yabai -m space 8 --label eight
    yabai -m space 9 --label nine
    yabai -m space 10 --label ten
    # assign apps to spaces
    yabai -m rule --add app="Alacritty" space=term
    yabai-m rule --add app="Visual Studio Code" space=code
    yabai -m rule --add app="Vivaldi" space=www
    yabai -m rule --add app="Google Chrome" space=seven
    yabai -m rule --add app="Microsoft Teams" space=chat
    yabai -m rule --add app="Slack" space=chat
    yabai -m rule --add app="Signal" space=chat
    yabai -m rule --add app="Spotify" space=music
    yabai -m rule --add app="Todoist" space=todo
    echo "yabai configuration loaded.."
  '';

  };

}
