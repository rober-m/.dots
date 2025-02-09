{
  pkgs,
  lib,
  config,
  ...
}: {
  # Fuse filesystem that returns symlinks to executables based on the PATH
  # of the requesting process. This is useful to execute shebangs on NixOS
  # that assume hard coded locations in locations like /bin or /usr/bin
  # etc.
  services.envfs.enable = lib.mkDefault true;

  # Why?: https://blog.thalheim.io/2022/12/31/nix-ld-a-clean-solution-for-issues-with-pre-compiled-executables-on-nixos/
  programs.nix-ld.enable = lib.mkDefault true;
  programs.nix-ld.libraries = with pkgs; [
    acl
    attr
    bzip2
    dbus
    expat
    fontconfig
    freetype
    fuse3
    icu
    libnotify
    libsodium
    libssh
    libunwind
    libusb1
    libuuid
    nspr
    nss
    stdenv.cc.cc
    util-linux
    zlib
    zstd
  ];
}
