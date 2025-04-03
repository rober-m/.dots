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
          configFile = ../../../shared/home/kanata.kbd;
        };
      };
    };
  };
}
