{
  lib,
  config,
  ...
}: {
  # Custom option config to enable zellij
  options = {
    customized.zellij.enable =
      lib.mkEnableOption "Enable zellij with personal config";
  };

  config = lib.mkIf config.customized.zellij.enable {
    programs.zellij = {
      enable = true;
    };
    home.file.zellij = {
      target = ".config/zellij/config.kdl";
      text = builtins.readFile ./config.kdl;
    };
    home.sessionVariables = {
      ZELLIJ_AUTO_ATTACH = "true";
    };
  };
}
