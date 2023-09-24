{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" # Docs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
        "vi-mode" # Docs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
      ];
      theme = "robbyrussell";
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
      #tr = "echo TODO "; # TODO: Send to trash
      gs = "git status"; # More aliases at git config

      # Git-related
      # See oh-my-zsh -> plugins -> git
      lg = "lazygit";

      # Quick movement
      iog = "cd ~/IOG/";
      hc = "cd ~/IOG/haskell-course/";
      pr = "cd ~/Projects/";
      sc = "cd ~/scratchpad/";
      dots = "cd ~/.dots && nvim ."; # cd before so nvim plugis work properly

      # Nix-related
      rebuild = "darwin-rebuild switch --flake ~/.dots#macbook";
      plutus-apps = "nix develop github:input-output-hk/plutus-apps/v1.2.0";
    };

    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" # Needed for homebrew
      # export KEYTIMEOUT=1 # Needed for ZSH vi mode
      VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true # For oh-my-zsh vi-mode
      eval "$(direnv hook zsh)" # Needed for direnv
    '';

    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = 1;
      IHP_EDITOR = "code --goto";
    };
  };
}
