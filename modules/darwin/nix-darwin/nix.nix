{...}: {
  nix.gc.interval = {
    Weekday = 0;
    Hour = 0;
    Minute = 0;
  }; # Run on the 0th day of the week at 00:00

  #ids.uids.nixbld = lib.mkForce 351;
  ids.gids.nixbld = 30000;

  nix.settings = {
    auto-optimise-store = false; # See: https://github.com/NixOS/nix/issues/7273
    system = "aarch64-darwin";
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

    # Disabling or relaxing the sandbox is sometimes needed to build packages in MacOS (e.g., kitty 39.1)
    # You can build the specific package with `nix build --option sandbox false "nixpkgs#kitty"`
    # You can also turn it off here for the whole system and turn it on again after the problematic package is built
    #sandbox = false; # false | relaxed | true

    # --------------------- FOR OBELISK -----------------------
    #binary-caches-parallel-connections = 40;
    # ---------------------------------------------------------
  };
}
