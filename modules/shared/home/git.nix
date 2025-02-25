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
        merge.conflictstyle = "zdiff3";
        init.defaultBranch = "main";
        #credential.helper = "osxkeychain";
        column.ui = "auto";
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicprefix = true;
          renames = true;
        };
        push = {
          default = "simple";
          autoSetRemote = true;
          followTags = true;
        };
        feth = {
          prune = true;
          pruneTags = true;
        };
        help.autocorrect = "prompt";
      };
      ignores = [".DS_Store"];
    };
  };
}
