{...}: {
  imports = [
    ../../../shared/system/kanata.nix # On nixos kanata is at the system level
    ./bootloader.nix
    ./networking.nix
    ./sound.nix
    ./time-and-locale.nix
    ./xremap.nix # Remapping keys
    ./kanata.nix # Custom keyboard layers
    ./fhs-compat.nix # FHS compatibility
  ];
}
