{
  lib,
  config,
  ...
}: {
  options = {
    customized.git.enable =
      lib.mkEnableOption "Enable Git with custom config";
  };

  config = lib.mkIf config.customized.git.enable {
    programs.git = {
      enable = true;
      userName = "Robertino Martinez";
      userEmail = "48034748+rober-m@users.noreply.github.com";
      aliases = {
        s = "status";
        c = "checkout";
        aa = "add .";
        cm = "commit -m";
        ca = "commt --amend --no-edit";
      };
      difftastic.enable = true;
      extraConfig = {
        github.user = "rober-m";
        pull.rebase = false;
        merge.conflictstyle = "diff3";
        init.defaultBranch = "main";
        #credential.helper = "osxkeychain";
      };
      ignores = [".DS_Store"];
    };
  };
}
