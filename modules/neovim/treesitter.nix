{ pkgs, inputs, system, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          -------------------------------- TREESITTER ---------------------------------------
          require'nvim-treesitter.configs'.setup {
            -- IMPORTANT: Don't use "ensure_installed" or "auto_install" because you will get an
            -- error. Install the parsers using nix.
            highlight = {
              enable = true
            },
            rainbow = {
                enable = true,
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table
                max_file_lines = nil
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
