{ pkgs, system, ... }:
let
  colors_tomorrow = import ./colors-base16-tomorrow.nix;
  colors_tokionight = import ./colors-tokio-night.nix;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = colors_tokionight;
      window = {
        opacity = 0.95;
        decorations = "none";
      };
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

