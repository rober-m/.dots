{...}: {
  nix.gc.interval = {
    Weekday = 0;
    Hour = 0;
    Minute = 0;
  }; # Run on the 0th day of the week at 00:00

  nix.configureBuildUsers = true; # TODO: should this be in common/configuration.nix?
  #ids.uids.nixbld = lib.mkForce 351;
  ids.gids.nixbld = 30000;

  nix.settings = {
    auto-optimise-store = false; # See: https://github.com/NixOS/nix/issues/7273
    system = "x86_64-darwin";
    extra-platforms = ["x86_64-darwin" "aarch64-darwin"];
    experimental-features = ["nix-command" "flakes"];
    extra-sandbox-paths = [
      "/System/Library/Frameworks"
      "/System/Library/PrivateFrameworks"
      "/usr/lib"
      "/private/tmp"
      "/private/var/tmp"
      "/usr/bin/env"
    ];

    # --------------------- FOR OBELISK -----------------------
    #binary-caches-parallel-connections = 40;
    #sandbox = false;
    # ---------------------------------------------------------
  };
}
