{
  pkgs,
  lib,
  ...
}:
# INFO: gtk.nix is a home-manager configuration!! Not a system-level one.
{
  home.packages = with pkgs; [
    dconf
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        scaling-factor = lib.hm.gvariant.mkUint32 2; # INFO: This works together with autorandr's transform
      };
    };
  };

  #  gtk = {
  #    enable = true;
  #    theme = {
  #      #name = "Nordic";
  #      #package = pkgs.nordic;
  #      name = "orchis-theme";
  #      package = pkgs.orchis-theme;
  #    };
  #    iconTheme = {
  #      name = "Adwaita";
  #      package = pkgs.gnome.adwaita-icon-theme;
  #    };
  #    cursorTheme = {
  #      name = "Adwaita";
  #      package = pkgs.gnome.adwaita-icon-theme;
  #    };
  #  };
}
