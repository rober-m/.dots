{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
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
      v = "nvim";
      cat = "bat";
      e = "exit";

      # Git-related
      gs = "git status";
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
      # Needed for homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)" 
    '';
    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = 1;
    };
  };

}
