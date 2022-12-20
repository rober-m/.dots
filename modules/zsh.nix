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
      rebuild = "darwin-rebuild switch --flake ~/.config#roberm";
      v = "nvim";
      cat = "bat";
    };
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)" 
    '';
    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = 1;
    };
  };

}
