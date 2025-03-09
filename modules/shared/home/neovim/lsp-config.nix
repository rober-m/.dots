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
      #rust-analyzer # Rust (Using rustup to install it instead of nixpkgs)
      nodePackages.vim-language-server # Vim
      nodePackages.typescript-language-server # Typescript
      deno
      nodePackages.yaml-language-server # Yaml
      nodePackages.bash-language-server # Bash
      nodePackages.vscode-langservers-extracted # HTML/CSS/JSON/ESLint extracted from VSCode
      tailwindcss-language-server # TailwindCSS
      marksman # Markdown.
      #ltex-ls # LaTeX and Markdown, and others (https://github.com/valentjn/ltex-ls)
      terraform-ls # Terraform
      #dart # Dart

      tinymist # Typst LSP
      typstyle # Typst formatter that tinymist uses
    ];
  };
}
