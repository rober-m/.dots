{...}: {
  imports = [
    ./neovim
    ./alacritty
    ./git.nix
    ./zsh.nix
    ./ssh.nix
    ./haskell.nix # Haskell-related binaries and config (withot nvim config)
    #./modules/vscode/vscode.nix # TODO: Try this config when I have time to fix it in case it breaks VSCode containers
  ];
}
