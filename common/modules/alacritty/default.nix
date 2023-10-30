{config, ...}:
#let
#colors_tomorrow = import ./colors-base16-tomorrow.nix;
#colors_tokionight = import ./colors-tokio-night.nix;
#in
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      colors = with config.colorScheme.colors; {
        # Default colors
        primary = {
          background = "0x${base00}";
          foreground = "0x${base06}";
        };

        # Normal colors
        normal = {
          black = "0x${base00}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base0A}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base06}";
        };

        # Bright colors
        bright = {
          black = "0x${base00}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base09}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base06}";
        };
      };
      window = {
        #opacity = 1;
        opacity = 0.92;
        #decorations = "none";
        padding = {
          x = 8;
          y = 8;
        };
      };
      font = {
        size = 19;
        normal.family = "Fira Code Nerd Font Mono"; # Hack Nerd Font
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
