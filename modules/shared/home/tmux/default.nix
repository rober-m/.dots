{
  lib,
  pkgs,
  config,
  ...
}: {
  # Custom option config to enable tmux with some plugins.
  options = {
    custom_tmux.enable =
      lib.mkEnableOption "Enable tmux with personal config";
  };

  config = lib.mkIf config.custom_tmux.enable {
    # Enable tmux with some plugins.
    programs.tmux = {
      enable = true;
      shortcut = "a";
      baseIndex = 1;
      newSession = true;
      # Stop tmux+escape craziness.
      #escapeTime = 0;

      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        catppuccin
      ];

      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
