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
              highlight = {
                enable = true
            },
            rainbow = {
                enable = true,
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil
            }
          }
          -----------------------------------------------------------------------------------
        '';
      }

    ];

  };

}
