{
  lib,
  pkgs,
  config,
  ...
}: {
  # Config needed for GitHub to use SSH
  # (Removed the "github.com" after "*" indicated in GH docs to avoid passphrase prompt all the time)
  options = {
    customized.ssh.enable =
      lib.mkEnableOption "Enable SSH with custom config";
  };

  config = lib.mkIf config.customized.ssh.enable {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      # identityFile = [
      #   "${config.home.homeDirectory}/.ssh/id_ed25519"
      # ];
      extraConfig =
        ''
          IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519
        ''
        + (
          if pkgs.stdenv.hostPlatform.isLinux
          then ''
          ''
          else if pkgs.stdenv.hostPlatform.isDarwin
          then ''
            UseKeychain yes
          ''
          else ""
        );
    };
    # home.file.ssh = {
    #   target = ".ssh/config";
    #   executable = false;
    #   text =
    #     if pkgs.stdenv.hostPlatform.isLinux
    #     then ''
    #       Host *
    #         AddKeysToAgent yes
    #         IdentityFile ~/.ssh/id_ed25519
    #     ''
    #     else if pkgs.stdenv.hostPlatform.isDarwin
    #     then ''
    #       Host *
    #         AddKeysToAgent yes
    #         UseKeychain yes
    #         IdentityFile ~/.ssh/id_ed25519
    #     ''
    #     else "";
    # };
  };
}
