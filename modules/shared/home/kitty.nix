{
  user-options,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;

    darwinLaunchOptions = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [
      "--single-instance"
      "--directory=/tmp/my-dir"
      "--listen-on=unix:/tmp/my-socket"
      #"--start-as=maximized"
    ];

    theme = "Catppuccin-Frappe"; # TODO: map to user-options.theme

    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      remember_window_size = false;
      initial_window_width = 1000;
      initial_window_height = 800;
    };

    font.name = "FiraCode Nerd Font";
    font.size = 13;

    # TODO: Add keybindings based on Alacritty's ones
    # keybindings = {
    #   "ctrl+c" = "copy_or_interrupt";
    #   "ctrl+f>2" = "set_font_size 20";
    # };

    environment = {LS_COLORS = "1";};
  };
}
