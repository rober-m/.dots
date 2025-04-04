{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    customized.kanata.enable =
      lib.mkEnableOption "Enable kanata (keyboard layout) with personal config";
  };

  config = lib.mkIf (config.customized.kanata.enable
    && pkgs.stdenv.hostPlatform.isLinux) {
    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          # TODO: move "swap CAPSLOCK and ESC" from xremap to kanata
          # INFO: I think I can't add comments inside the kanata config file without breaking it.
          configFile = ../../../shared/home/kanata.kbd;
        };
      };
    };
  };
}
