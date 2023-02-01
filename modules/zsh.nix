{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
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
      #tr = "echo TODO "; # TODO: Send to trash

      # Git-related 
      # See oh-my-zsh -> plugins -> git
      lg = "lazygit";

      # Quick movement
      hc = "cd ~/IOG/haskell-course/";
      pr = "cd ~/Projects/";
      sc = "cd ~/deleteMeDir/ && nvim ."; # cd before so nvim plugis work properly

      # Nix-related
      rebuild = "darwin-rebuild switch --flake ~/.config#roberm";
      dots = "cd ~/.config && nvim ."; # cd before so nvim plugis work properly
    };
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" # Needed for homebrew
      # export KEYTIMEOUT=1 # Needed for ZSH vi mode
      VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true # For oh-my-zsh vi-mode
    '';
    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = 1;
    };
  };

}
