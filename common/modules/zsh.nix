{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" # Docs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
        "vi-mode" # Docs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
        "ssh-agent" # Docs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
      ];
      theme = "robbyrussell"; # This is not only colors, but also prompt config.
    };

    dirHashes = {
      iog = "$HOME/IOG";
      hc = "$HOME/IOG/haskell-course";
      pr = "$HOME/Projects";
      sc = "$HOME/scratchpad";
    };
    # localVariables = {};
    shellAliases = {
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -la";
      v = "nvim";
      cat = "bat";
      e = "exit";
      c = "clear";
      gs = "git status"; # More aliases at git config

      # Git-related
      # See oh-my-zsh -> plugins -> git
      lg = "lazygit";

      # Quick movement
      dots = "cd ~/.dots && nvim ."; # cd before so nvim plugis work properly

      # Nix-related
      plutus-apps = "nix develop github:input-output-hk/plutus-apps/v1.2.0";
    };

    # Extra commands that should be added to {file}`.zshrc`.
    initExtra = ''
      # MacOS-specific ZSH configuration
      if [[ $(uname) == "Darwin" ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)" # Needed for homebrew
      fi
    '';

    profileExtra = ''
      # export KEYTIMEOUT=1 # Needed for ZSH vi mode
    '';

    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = 1;
      IHP_EDITOR = "code --goto";
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#888"; # Change autosuggest highligh color
      VI_MODE_RESET_PROMPT_ON_MODE_CHANGE = true; # For oh-my-zsh vi-mode
    };
  };
}
