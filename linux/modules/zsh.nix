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

    # Linux-specific extra commands that should be added to {file}`.zshrc`.
    initExtra = ''
      # Linux-specific ZSH configuration
      export PATH=$HOME/.local/bin/:$PATH
      weather-cli -l 38.7 -g 9.1
    '';
  };
}
