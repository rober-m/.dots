{...}: {
  imports = [
    ./neovim
    ./alacritty
    ./git.nix
    ./zsh.nix
    ./haskell.nix # Haskell-related binaries and config (withot nvim config)
    ./vscode
  ];
}
