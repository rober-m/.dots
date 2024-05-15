{...}: {
  #------------------------------------------------------------------------------------------------
  #--------------------------------- SHARED SYSTEM CONFIG -----------------------------------------

  environment.variables.EDITOR = "nvim";
  environment.pathsToLink = ["/share/zsh"]; # Needed by https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enableCompletion

  #------------------------------------------------------------------------------------------------
  #----------------------------------- SHARED NIX CONFIG ------------------------------------------

  nix.gc = {
    automatic = true;
    # INFO: The time interval is set different for nix-darwin. So, I moved that to each machine's config.
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/" # Default NixOS cache
      "https://nixcache.reflex-frp.org" # Obelisk cache
      "https://cache.iog.io" # IOG (IOHK) cache
      "https://digitallyinduced.cachix.org" # IHP Web Framework cache
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Default NixOS cache key
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" # Obelisk cache key
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" # IOG (IOHK) cache key
      "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE=" # IHP Web Framework cache key
    ];
    trusted-users = [
      "@admin"
    ];
    experimental-features = ["nix-command" "flakes"];

    # --------------------- FOR OBELISK -----------------------
    #binary-caches-parallel-connections = 40;
    #sandbox = false;
    # ---------------------------------------------------------
  };
}
