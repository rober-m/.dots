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
    && pkgs.stdenv.hostPlatform.isDarwin) {
    home.packages = with pkgs; [
      kanata
    ];
    home.file.".config/kanata/kanata.kbd".source = ../../shared/home/kanata.kbd;
  };
}
