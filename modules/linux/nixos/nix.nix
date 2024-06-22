{
  pkgs,
  inputs,
  ...
}: {
  #------------------------------------------------------------------------------------------------
  #-------------------------------- NIXOS-SPECIFIC NIX CONFIG -------------------------------------

  system.stateVersion = "23.05";

  # Collect garbage every week
  nix.gc.dates = "weekly";

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0";
  };

  # Overlay to update MEGASync to the latest version
  nixpkgs.overlays = [
    #(import ../../../overlays/magasync.nix)
  ];

  # Auto-upgrade system
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "weekly";
    randomizedDelaySec = "1d";
  };
}
