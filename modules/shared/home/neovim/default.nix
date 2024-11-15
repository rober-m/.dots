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
    ./dap.nix # Debugging adapter protocol
    ./telescope.nix # Fuzzy finder
    ./bufferline.nix # Cool buffer tabs
    ./lualine.nix # Cool status-line
    ./themes # Theme
    ./treesitter.nix # Treesitter config
    ./leap.nix # General-purpose motion plugin
    ./nvim-tree.nix # Tree file explorer
    ./comments.nix # To easily comment/uncomment code
    ./haskell.nix # All my Haskell config (using haskell-tools)
    ./rust.nix # All my Rust config (using rustaceanvim)
    ./toggleterm.nix # Persist and toggle multiple terminals
    ./gitsigns.nix # Git decorations
    ./lazygit.nix # Git TUI
    ./nvim-notify.nix # Notifications
    #./chatGPT.nix # ChatGPT integration TODO: Configure it
    ./copilot.nix # GitHub Copilot
    ./copilotChat.nix # GitHub Copilot's chat integration
    ./luasnip.nix # Snippets
    #---------------- IMPORTANT ----------------
    # INFO: which-key must be the last import for it to recognize the keybindings of
    # previous imports.
    ./which-key.nix # Pannel showing available keymappings live.
  ];

  options = {
    customized.neovim.enable =
      lib.mkEnableOption "Enable Neovim with personal config";
  };
  config = lib.mkIf config.customized.neovim.enable {
    # DOCS: https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.enable
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true; # Add NodeJs. It's required by some plugins.

      # Full list of plugins here:
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix

      # Plugins without configuration
      plugins = with pkgs.vimPlugins; [
        packer-nvim # This might be related to packerpath error. Always install, just in case
        plenary-nvim # Lua functions that many plugins depend on
        lazy-nvim # Lazy package management for Neovim
        dressing-nvim # Neovim plugin to improve the default vim.ui interfaces
        sniprun # Run code snippets
        avante-nvim # A modern Neovim UI
        {
          plugin = otter-nvim; # LSP for code embeded in documents
          type = "lua";
          config =
            /*
            lua
            */
            ''
              ------------------------------------ OTTER -------------------------------------------
              -- WARNING: This doesn't work. I don't know why.
              -- DOCS: https://github.com/jmbuhr/otter.nvim
              -- table of embedded languages to look for.
              -- default = nil, which will activate
              -- any embedded languages found
              local languages = {'lua'}
              --local languages = nil
              -- enable completion/diagnostics
              -- defaults are true
              local completion = true
              local diagnostics = true
              -- treesitter query to look for embedded languages
              -- uses injections if nil or not set
              local tsquery = nil
              require('otter').activate(languages, completion, diagnostics, tsquery)
            '';
        }
        {
          plugin = twilight-nvim; # Dim inactive portions of the code you're editing
          type = "lua";
          config =
            /*
            lua
            */
            ''
              ------------------------------------ TWILIGHT -------------------------------------------
              -- DOCS: https://github.com/folke/twilight.nvim
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

      # INFO: Packages in `extraPackages` are installed only inside the Neovim environment. Install them separately if you want to use them outside of Neovim.
      extraPackages = with pkgs; [
        shellcheck # Shell script analysis tool (Run shellcheck <script>)
        statix # `statix check file.nix` Lints and suggestions for the Nix programming language.
        proselint # A linter for English prose
      ];

      extraLuaConfig = builtins.readFile ./default.lua;
    };
  };
}
