{...}: {
  programs.zsh = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.dots#framework";
    };

    oh-my-zsh = {
      plugins = [
        # I use this only on linux. Mac doesn't need it.
        "ssh-agent" # Docs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
      ];
    };
  };
}
