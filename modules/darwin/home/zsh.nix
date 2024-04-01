{...}: {
  programs.zsh = {
    shellAliases = {
      rebuild = "darwin-rebuild switch --flake ~/.dots#macbook";
      collect-garbage = "echo 'TODO: Implement collect-garbage in Darwin'";
    };

    # MacOS-specific extra commands that should be added to {file}`.zshrc`.
    initExtra = ''
      # MacOS-specific ZSH configuration
      eval "$(/opt/homebrew/bin/brew shellenv)" # Needed for homebrew

      export PATH=$HOME/.cabal/bin/:$PATH # Add cabal-installed binaries to PATH
      weather-cli -l 38 -g 9
    '';

    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = 1;
    };
  };
}
