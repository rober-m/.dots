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
            ensure_installed = { "haskell", "nix", "typescript", "lua", "rust" },
            auto_install = true
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
