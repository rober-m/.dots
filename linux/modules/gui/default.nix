{pkgs, ...}: {
  # INFO: gtk.nix is a home-manager configuration!! Not a system-level one.

  imports = [
    #./gnome.nix
    ./kde.nix
    #./autorandr.nix
    ./wayland
  ];
}
