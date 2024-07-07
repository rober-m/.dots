{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-ts-autotag # Automatically close and rename HTML tags
      nvim-treesitter-context # Show the context of the current function
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            -------------------------------- TREESITTER ---------------------------------------
            require'nvim-treesitter.configs'.setup {
              -- WARN: Don't use "ensure_installed" or "auto_install" because you will get an
              -- error. Install the parsers using nix.
              highlight = {
                enable = true
              },
              rainbow = {
                  enable = true,
                  extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table
                  max_file_lines = nil
              },
              -- Enable autotag using nvim-ts-autotag
              autotag = {
                enable = true,
              }
            }
            -----------------------------------------------------------------------------------
          '';
      }
    ];

    extraPackages = with pkgs; [
      tree-sitter
    ];
  };
}
