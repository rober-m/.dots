{
  lib,
  config,
  ...
}: {
  options = {
    customized.git.enable =
      lib.mkEnableOption "Enable Git with custom tools and config";
  };

  config = lib.mkIf config.customized.git.enable {
    # -------------------------------------------------------------
    # -------------------------- LazyGit --------------------------
    programs.lazygit = {
      enable = lib.mkDefault true;
      settings = {
        git.paging.externalDiffCommand = "difft --color=always --display=side-by-side --syntax-highlight=off";
      };
    };
    # -------------------------------------------------------------
    # ---------------------------- Git ----------------------------
    programs.git = {
      enable = lib.mkDefault true;
      userName = "Robertino Martinez";
      userEmail = "48034748+rober-m@users.noreply.github.com";
      aliases = {
        s = "status";
        c = "checkout";
        aa = "add .";
        cm = "commit -m";
        ca = "commt --amend --no-edit";
      };
      # TODO: Add GPG key to Mac and uncomment this
      #signing = {
      #  signByDefault = true;
      #};
      difftastic = {
        enable = true;
        color = "always";
      };
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
