{...}: let
  #colors_tomorrow = import ./colors-base16-tomorrow.nix;
  colors_tokionight = import ./colors-tokio-night.nix;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = colors_tokionight.storm;
      window = {
        #opacity = 1;
        #opacity = 0.92;
        opacity = 0.90;
        #decorations = "none";
        padding = {
          x = 8;
          y = 8;
        };
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
      # TODO: Change commands depending on the operating system. Do I have to?
      key_bindings = [
        #{ key = ""; mods = ""; chars/action = ""; }
        ######## Common ########
        {
          key = "Escape";
          mods = "Control";
          action = "ToggleViMode";
        }
        ######## MacOS ########
        {
          key = "N";
          mods = "Command";
          action = "SpawnNewInstance";
        }
        {
          key = "C";
          mods = "Command";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Command";
          action = "Paste";
        }
        ######## Linux ########
        {
          key = "N";
          mods = "Control";
          action = "SpawnNewInstance";
        }
        {
          key = "C";
          mods = "Alt";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Alt";
          action = "Paste";
        }
      ];
    };
  };
}
