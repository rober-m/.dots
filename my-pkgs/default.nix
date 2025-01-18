# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
# TODO: Organize custom packages and overlays better.
{pkgs}: {
  my-dioxus-cli = pkgs.callPackage ../../../my-pkgs/my-dioxus-cli.nix {};
}
