{
  pkgs,
  # config,
  # inputs,
  ...
}: let
  # nix-colors-lib = inputs.nix-colors.lib.contrib {inherit pkgs;};
  selected-colorscheme = "tokyonight"; # catppuccin-macchiato | gruvbox | dracula | onedark
in {
  programs.neovim = {
    # Use base 16 colros (if using this, comment all other themes)
    #plugins = [
    #{
    #  plugin = nix-colors-lib.vimThemeFromScheme {scheme = config.colorScheme;};
    #  config = "colorscheme nix-${config.colorScheme.slug}";
    #}
    #];
    plugins = with pkgs.vimPlugins; [
      # themes with no config
      sonokai
      dracula-nvim
      gruvbox
      papercolor-theme
      # themes WITH config
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = builtins.readFile ./catpuccin-nvim.lua;
      }
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = builtins.readFile ./tokyonight.lua;
      }
      {
        plugin = onedark-nvim;
        type = "lua";
        config = builtins.readFile ./onedark.lua;
      }
    ];

    extraConfig = ''
      lua << EOF
      ------------------------------- THEMES EXTRA CONFIG ------------------------------
      --vim.opt.background = "dark" -- Values are "dark" or "light" to indicate the mode.
      vim.cmd([[ colorscheme ${selected-colorscheme} ]])

      vim.o.termguicolors = true

      -- Next block: Remove all background colors so it looks transparent
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" }) -- Remove NvimTree background
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" }) -- Remove left gutter background
      -----------------------------------------------------------------------------------
      EOF
    '';
  };
}
