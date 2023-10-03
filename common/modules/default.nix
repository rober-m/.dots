{...}: {
  imports = [
    ./neovim
    ./alacritty
    ./git.nix
    ./zsh.nix
    ./ssh.nix
    ./haskell.nix # Haskell-related binaries and config (withot nvim config)
    ./firefox.nix
    ./vscode
  ];
}
