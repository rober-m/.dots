{...}: {
  programs.zsh = {
    shellAliases = {
      rebuild = "darwin-rebuild switch --flake ~/.dots#macbook";
    };
  };
}
