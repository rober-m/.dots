{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        # This pluging provides default configurations for LSP neovim clients.
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./lsp-config.lua;
      }
    ];

    extraPackages = with pkgs; [
      # LANGUAGE SERVERS
      nil # Nix
      lua-language-server # Lua
      rust-analyzer # Rust
      nodePackages.vim-language-server # Vim
      nodePackages.typescript-language-server # Typescript
      nodePackages.yaml-language-server # Yaml
      nodePackages.bash-language-server # Bash
      nodePackages.vscode-langservers-extracted # HTML/CSS/JSON/ESLint extracted from VSCode
      #tailwindcss-language-server # TailwindCSS FIXME: I think it is not working because nixpkgs is not up to date
      #marksman # Markdown. IMPORTANT: I had to install it using "nix profile install nixpkgs#marksman"
      #ltex-ls # LaTeX and Markdown, and others (https://github.com/valentjn/ltex-ls)
    ];
  };
}
