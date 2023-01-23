{ pkgs, system, ... }:
let
  colors_tomorrow = {
    # Tomorrow (https://github.com/aarowill/base16-alacritty/blob/master/colors/base16-tomorrow.yml)
    # Default colors
    primary = {
      background = "0xffffff";
      foreground = "0x4d4d4c";
    };
    # Colors the cursor will use if `custom_cursor_colors` is true
    cursor = {
      text = "0xffffff";
      cursor = "0x4d4d4c";
    };
    # Normal colors
    normal = {
      black = "0xffffff";
      red = "0xc82829";
      green = "0x718c00";
      yellow = "0xeab700";
      blue = "0x4271ae";
      magenta = "0x8959a8";
      cyan = "0x3e999f";
      white = "0x4d4d4c";
    };
    # Bright colors
    bright = {
      black = "0x8e908c";
      red = "0xf5871f";
      green = "0xe0e0e0";
      yellow = "0xd6d6d6";
      blue = "0x969896";
      magenta = "0x282a2e";
      cyan = "0xa3685a";
      white = "0x1d1f21";
    };
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      # import = "./tokio-night.yaml";
      # colors = "*tokyo-night";
      colors = colors_tomorrow;
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

