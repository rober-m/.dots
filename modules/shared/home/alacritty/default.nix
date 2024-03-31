{
  lib,
  config,
  user-options,
  ...
}: {
  options = {
    customized.alacritty.enable = lib.mkEnableOption "Enable custom alacritty configuration";
  };

  config = lib.mkIf config.customized.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        colors = with config.colorScheme.palette; {
          draw_bold_text_with_bright_colors = true;
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
          opacity = user-options.opacity;
          startup_mode = "Maximized";
          #decorations = "none";
          padding = {
            x = 8;
            y = 8;
          };
        };
        font = {
          size = 15;
          normal.family = "FiraCode Nerd Font";
          #normal.family = "Hack Nerd Font";
        };
        cursor = {
          style.shape = "Block";
        };
        # TODO: Change commands depending on the operating system. Do I have to?
        keyboard.bindings = [
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
  };
}
