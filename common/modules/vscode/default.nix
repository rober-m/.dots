{pkgs,lib, ...}: {
  #TODO: Add language servers (the ones in the nvim config) here? Add them to home.nix? Let VSCode manage the installation?
  programs.vscode = {
    enable = true;
    userSettings = lib.importJSON ./settings.json;
    extensions = with pkgs.vscode-extensions; [
      # General
      vscodevim.vim # Vim (https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)
      github.copilot # Copilot (https://marketplace.visualstudio.com/items?itemName=github.copilot)
      ms-vsliveshare.vsliveshare # Live Share (https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare)
      arrterian.nix-env-selector # Nix Env Selector (https://marketplace.visualstudio.com/items?itemName=arrterian.nix-env-selector)

      # Git
      github.vscode-pull-request-github # GitHub Pull Requests (https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)
      eamodio.gitlens # GitLens (https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)

      # Containers and remote
      #ms-vscode-remote.remote-containers # Dev containers (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
      #ms-vscode-remote.remote-ssh # SSH (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
      ms-azuretools.vscode-docker # Docker (https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
      #ms-vscode-remote.remote-ssh-edit # SSH Editing (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh-edit)

      # Languages
      haskell.haskell # Haskell (https://marketplace.visualstudio.com/items?itemName=haskell.haskell)
      justusadam.language-haskell # Haskell Syntax Highlighting (https://marketplace.visualstudio.com/items?itemName=justusadam.language-haskell)
      bbenoist.nix # Nix (https://marketplace.visualstudio.com/items?itemName=bbenoist.nix)
      jnoortheen.nix-ide # Nix IDE (https://marketplace.visualstudio.com/items?itemName=jnoortheen.nix-ide)

      # Frontend
      dbaeumer.vscode-eslint # ESLint (https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
      esbenp.prettier-vscode # Prettier (https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
      bradlc.vscode-tailwindcss # Tailwind CSS (https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss)

      # Themes
      dracula-theme.theme-dracula # Dracula Official (https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)

      # Missing from Nixpkgs:
      # direnv (https://marketplace.visualstudio.com/items?itemName=Rubymaniac.vscode-direnv)
      # Haskell HSX (https://marketplace.visualstudio.com/items?itemName=s0kil.vscode-hsx)
      # ES7+ React/Redux/React-Native snippets (https://marketplace.visualstudio.com/items?itemName=dsznajder.es7-react-js-snippets)
      # Prettier ESLint (https://marketplace.visualstudio.com/items?itemName=rvest.vs-code-prettier-eslint)
      # Remote Explorer (https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer)
      # stylish-haskell (https://marketplace.visualstudio.com/items?itemName=vigoo.stylish-haskell)
      # TODO Highlight (https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)
    ];
  };
}
