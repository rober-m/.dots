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

      # Nix-related
      rebuild = "darwin-rebuild switch --flake ~/.config#roberm";
      dots = "cd ~/.config && nvim ."; # cd before so nvim plugis work properly

      # Projects
      course = "cd ~/IOG/haskell-course && nvim ."; # cd before so nvim plugis work properly
    };
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" 
    '';
    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = 1;
    };
  };

}
