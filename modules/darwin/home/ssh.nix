{...}: {
  # Config needed for SSH to GitHub
  # (Removed the "github.com" after "*" indicated in GH docs  to avoid passphrase prompt all the time)
  home.file.sshCustomConfig = {
    target = ".ssh/config";
    executable = false;
    text = ''
      Host *
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
