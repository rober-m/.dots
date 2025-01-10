{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    customized.kitty.enable = lib.mkEnableOption "Enable custom Kitty configuration";
  };

  config = lib.mkIf config.customized.kitty.enable {
    programs.kitty = {
      enable = true;

      darwinLaunchOptions = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [
        "--single-instance"
        "--directory=/tmp/my-dir"
        "--listen-on=unix:/tmp/my-socket"
        #"--start-as=maximized"
      ];

      themeFile = "Catppuccin-Frappe"; # TODO: map to user-options.theme

      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        remember_window_size = true;
        initial_window_width = 1000;
        initial_window_height = 800;
        background_opacity = "1";
        background_image = "~/.dots/wallpapers/japan_traditional_street.png"; # Only PNG.
        background_image_layout = "scaled";
        background_tint = "0.90"; # Mix background color with background image
        macos_option_as_alt = true;
        copy_on_select = true;
      };

      font.name = "FiraCode Nerd Font";
      font.size = 13;

      # TODO: Add keybindings based on Alacritty's ones
      #keybindings = {
      #  "ctrl+c" = "copy_or_interrupt";
      #  "ctrl+f>2" = "set_font_size 20";
      #};

      environment = {LS_COLORS = "1";};
    };
  };
}
