{ config, pkgs, lib, ... }:
{
  # Neovim
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # Add NodeJs since it's required by some plugins I use.
    withNodeJs = true;

  # Add plugins using my `packer` function.
  plugins = with pkgs.vimPlugins; [
    # Apperance, interface, UI, etc.
    bufferline-nvim
    galaxyline-nvim 
    gitsigns-nvim
    indent-blankline-nvim
    {
      plugin = telescope-nvim;
      config = ''
        require('telescope').setup{
          defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            mappings = {
              i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
              }
            }
          },
          pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
          },
          extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
          }
        }
      ''; 
    }
    # { plugin = toggleterm-nvim; config = ""; }

    # # Completions
    # copilot-vim

    # # Language servers, linters, etc.
    # {
    #   plugin = lsp_lines-nvim;
    #   config = ''
    #     require'lsp_lines'.setup()
    #     vim.diagnostic.config({ virtual_lines = { only_current_line = true } })'';
    # }
    # { plugin = lspsaga-nvim; config = ""; }
    # { plugin = null-ls-nvim; config = ""; }
    # { plugin = nvim-lspconfig; config = ""; }

    # nvim-treesitter.withAllGrammars
    # vim-haskell-module-name
    # vim-polyglot

    # # Editor behavior
    # { plugin = comment-nvim; config = "require'comment'.setup()"; }
    # { plugin = editorconfig-vim; setup = "vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }"; }
    # { plugin = tabular; vscode = true; }
    # { plugin = vim-surround; vscode = true; }
    # { plugin = nvim-lastplace; config = "require'nvim-lastplace'.setup()"; }
    # {
    #   use = vim-pencil;
    #   setup = "vim.g['pencil#wrapModeDefault'] = 'soft'";
    #   config = "vim.fn['pencil#init'](); vim.wo.spell = true";
    #   ft = [ "markdown" "text" ];
    # }

    # # Misc
    # { use = direnv-vim; }
    # { use = vim-eunuch; vscode = true; }
    # { use = vim-fugitive; }
    # { use = which-key-nvim; opt = true; }
  ];

  # Required packages -------------------------------------------------------------------------- {{{
  extraPackages = with pkgs; [
    #neovim-remote

    # Language servers, linters, etc.
    # See `../configs/nvim/lua/malo/nvim-lspconfig.lua` and
    # `../configs/nvim/lua/malo/null-ls-nvim.lua` for configuration.

    # Bash
    nodePackages.bash-language-server
    shellcheck

    # Javascript/Typescript
    nodePackages.typescript-language-server

    # Nix
    deadnix
    statix
    nil
    nixpkgs-fmt

    # Vim
    nodePackages.vim-language-server

    #Other
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    proselint
    sumneko-lua-language-server
  ];

  };
}