{
  lib,
  config,
  ...
}: {
  # Custom option config to enable tmux with some plugins.
  options = {
    customized.kanata.enable =
      lib.mkEnableOption "Enable kanata (keyboard layout) with personal config";
  };

  # TODO: Replace xremap with kanata

  config = lib.mkIf config.customized.kanata.enable {
    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          extraDefCfg = "process-unmapped-keys yes";
          config = builtins.readFile ./kanata.kbd;
        };
      };
    };
  };
}
