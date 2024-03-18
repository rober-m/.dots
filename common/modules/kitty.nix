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
    ];

    theme = "Catppuccin-Frappe"; # TODO: map to user-options.theme

    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
    };

    font.name = "FiraCode Nerd Font";
    font.size = 14;

    # TODO: Add keybindings based on Alacritty's ones
    # keybindings = {
    #   "ctrl+c" = "copy_or_interrupt";
    #   "ctrl+f>2" = "set_font_size 20";
    # };

    environment = {LS_COLORS = "1";};
  };
}
