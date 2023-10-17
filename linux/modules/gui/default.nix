{...}: {
  # INFO: gtk.nix is a home-manager configuration!! Not a system-level one.

  imports = [
    ./xserver.nix
    ./autorandr.nix
  ];
}
