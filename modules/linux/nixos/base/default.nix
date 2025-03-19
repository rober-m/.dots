{...}: {
  imports = [
    ./kanata-linux.nix
    ./bootloader.nix
    ./networking.nix
    ./sound.nix
    ./time-and-locale.nix
    ./xremap.nix # Remapping keys
    ./fhs-compat.nix # FHS compatibility
  ];
}
