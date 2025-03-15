{...}: {
  imports = [
    ../../../shared/system/kanata.nix # On nixos kanata is at the system level
    ./bootloader.nix
    ./networking.nix
    ./sound.nix
    ./time-and-locale.nix
    ./xremap.nix # Remapping keys
    ./fhs-compat.nix # FHS compatibility
  ];
}
