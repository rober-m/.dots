{...}: {
  programs.zsh = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.dots#framework";
    };
  };
}
