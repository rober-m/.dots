{pkgs, ...}: {
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
}
