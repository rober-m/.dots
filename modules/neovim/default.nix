{ config, pkgs, lib, ... }:
{

  #################### CONFIG INSPIRED BY: #########################

  # https://github.com/srid/nixos-config/blob/master/home/neovim.nix

  ##################################################################

  imports = [
    ./lsp-config.nix # Lsp config
    ./nvim-cmp.nix # Completion engine with completion sources
    ./telescope.nix # Fuzzy finder
    ./bufferline.nix # Cool buffer tabs
    #./galaxyline.nix # Cool status-line
    ./themes.nix # Theme
    ./treesitter.nix # Treesitter config
    ./leap.nix #  General-purpose motion plugin
    ./nvim-tree.nix # Tree file explorer
    ./comments.nix # To easily comment/uncomment code
    ./haskell.nix # All my Haskell config (using haskell-tools
    ./toggleterm.nix.nix # Persist and toggle multiple terminals
    # ./rust.nix

    # which-key must be the last import for it to recognize the keybindings of
    # previous imports.
    ./which-key.nix # Pannel showing available keymappings live.
  ];

  # Docs: https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true; # Add NodeJs is required by some plugins

    # Full list here:
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-notify; # Notifications for Nvim. Docs: https://github.com/rcarriga/nvim-notify/
        type = "lua";
        config = ''
          ----------------------------------- NVIM-NOTIFY ----------------------------------------
          -- NOTE: Make sure to use a font with supported icons (nerd-fonts)
          vim.opt.termguicolors = true -- 24-bit colour is required
          require("notify").setup({
            background_colour = "#000000",
          })
          vim.notify = require("notify")
          ----------------------------------------------------------------------------------------- 
        '';
      }
      {
        plugin = lazygit-nvim;
        type = "lua";
        config = ''
          --------------------------------------- LAZYGIT -----------------------------------------
          require("which-key").register({
                                g = {
                                  name = "git",
                                  g = { ":LazyGit<cr>", "LazyGit" }, 
                                },
                              }, { prefix = "<leader>" })
          ----------------------------------------------------------------------------------------- 
        '';
      }

      # gitsigns-nvim
      # indent-blankline-nvim

      # vim-nix

      # vim-markdown

      # { plugin = toggleterm-nvim; config = ""; }

      # # Completions
      copilot-vim

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
    ];

    # Required packages -------------------------------------------------------------------------- {{{
    extraPackages = with pkgs; [
      #neovim-remote
      lazygit

      # Language servers, linters, etc.
      # See `../configs/nvim/lua/malo/nvim-lspconfig.lua` and
      # `../configs/nvim/lua/malo/null-ls-nvim.lua` for configuration.

      shellcheck # Shell script analysis tool (Run shellcheck <script>)


      # Nix
      deadnix
      statix
      nil
      nixpkgs-fmt

      #Other
      proselint
    ];

    extraConfig = ''
      lua << EOF
      ${builtins.readFile ./init.lua}
      EOF
    '';

  };
}

