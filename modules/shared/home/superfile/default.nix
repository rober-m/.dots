{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    customized.superfile.enable =
      lib.mkEnableOption "Enable superfile with personal config";
  };

  config = lib.mkIf config.customized.superfile.enable {
    home.packages = with pkgs; [
      superfile
    ];
    home.file.superfileHotkeys = {
      target =
        if pkgs.stdenv.hostPlatform.isLinux
        then ".config/superfile/hotkeys.toml"
        else "Library/Application Support/superfile/hotkeys.toml";
      text = builtins.readFile ./vimHotkeys.toml;
    };
    home.sessionVariables = {
      ZELLIJ_AUTO_ATTACH = "true";
    };
  };
}
