
{ pkgs, system, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      # import = "./tokio-night.yaml";
      # colors = "*tokyo-night";
      window.opacity = 0.95;
      font = {
        size = 17;
        normal.family = "Hack Nerd Font";
      };
      draw_bold_text_with_bright_colors = true;
      cursor = {
        style.shape = "Block";
        blinking = "Off";
      };
      key_bindings = [
        #{ key = ""; mods = ""; chars/action = ""; }
        { key = "N"; mods = "Command"; action = "SpawnNewInstance"; }
      ];
    };
  };

}