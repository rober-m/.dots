{...}: {
  imports = [
    ./bootloader.nix
    ./networking.nix
    ./sound.nix
    ./time-and-locale.nix
    ./xremap.nix # Remapping keys
    ./kanata.nix # Custom keyboard layers
  ];
}
