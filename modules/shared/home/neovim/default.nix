{
  lib,
  pkgs,
  config,
  ...
}: {
  # CONFIG INSPIRED BY: https://github.com/srid/nixos-config/blob/master/home/neovim.nix

  imports = [
    ./lsp-config.nix # Lsp config
    ./nvim-cmp.nix # Completion engine with completion sources
    ./telescope.nix # Fuzzy finder
    ./bufferline.nix # Cool buffer tabs
    ./lualine.nix # Cool status-line
    ./themes # Theme
    ./treesitter.nix # Treesitter config
    ./leap.nix # General-purpose motion plugin
    ./nvim-tree.nix # Tree file explorer
    ./comments.nix # To easily comment/uncomment code
    #./haskell.nix # All my Haskell config (using haskell-tools)
    ./toggleterm.nix # Persist and toggle multiple terminals
    ./gitsigns.nix # Git decorations
    ./lazygit.nix # Git TUI
    ./nvim-notify.nix # Notifications
    ./chatGPT.nix # ChatGPT integration TODO: Configure it
    # which-key must be the last import for it to recognize the keybindings of
    # previous imports.
    ./which-key.nix # Pannel showing available keymappings live.
  ];

  options = {
    customized.neovim.enable =
      lib.mkEnableOption "Enable Neovim with personal config";
  };
  config = lib.mkIf config.customized.neovim.enable {
    # Docs: https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true; # Add NodeJs. It's required by some plugins.

      # Full list of plugins here:
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix

      # Plugins without configuration
      plugins = with pkgs.vimPlugins; [
        copilot-vim # GitHub Copilot
        packer-nvim # This might be related to packerpath error. Always install, just in case
        {
          plugin = twilight-nvim; # Dim inactive portions of the code you're editing
          type = "lua";
          config = ''
            ------------------------------------ TWILIGHT -------------------------------------------
            -- Docs: https://github.com/folke/twilight.nvim
            require('twilight').setup{
              dimming = {
                alpha = 0.5, -- amount of dimming
                -- we try to get the foreground from the highlight groups or fallback color
                color = { "Normal", "#ffffff" },
                term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
                inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
              },
              context = 10, -- amount of lines we will try to show around the current line
              treesitter = true, -- use treesitter when available for the filetype
              -- treesitter is used to automatically expand the visible text,
              -- but you can further control the types of nodes that should always be fully expanded
              expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                "function",
                "method",
                "table",
                "if_statement",
              },
              exclude = {}, -- exclude these filetypes
            }
            -----------------------------------------------------------------------------------------

          '';
        }
      ];

      extraPackages = with pkgs; [
        shellcheck # Shell script analysis tool (Run shellcheck <script>)
        statix # `statix check file.nix` Lints and suggestions for the Nix programming language.
        proselint # A linter for English prose
      ];

      extraConfig = ''
        lua << EOF
        ${builtins.readFile ./default.lua}
        EOF
      '';
    };
  };
}
