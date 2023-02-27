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
    ./lualine.nix # Cool status-line
    ./themes.nix # Theme
    ./treesitter.nix # Treesitter config
    ./leap.nix #  General-purpose motion plugin
    ./nvim-tree.nix # Tree file explorer
    ./comments.nix # To easily comment/uncomment code
    ./haskell.nix # All my Haskell config (using haskell-tools
    ./toggleterm.nix # Persist and toggle multiple terminals
    ./gitsigns.nix # Git decorations
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
      packer-nvim # For plugins that aren't on nixpkgs (see ./init.lua)
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

    ];

    extraPackages = with pkgs; [
      lazygit

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

