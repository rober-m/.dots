{config, pkgs, ...}:{

  environment.systemPackages = with pkgs; [
    nordic

  ];

  # This next stuff is technically not necessary if you're going to use
  # a theme chooser or set it in your user settings, but if you go
  # through all this effort might as well set it system-wide.
  #
  # Oddly, NixOS doesn't have a module for this yet.
  environment.etc."xdg/gtk-4.0/gtkrc".text = ''
    gtk-theme-name=Nordic
    gtk-cursor-theme-name=Adwaita
    gtk-icon-theme-name=Adwaita
    gtk-application-prefer-dark-theme=true
    gtk-button-images=true
    gtk-cursor-theme-size=24
    gtk-decoration-layout=icon:minimize,maximize,close
    gtk-enable-animations=true
    gtk-font-name=Noto Sans,  10
    gtk-menu-images=true
    gtk-modules=colorreload-gtk-module
    gtk-primary-button-warps-slider=false
    gtk-toolbar-style=3
    gtk-xft-dpi=98304
  '';

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Nordic
    gtk-cursor-theme-name=Adwaita
    gtk-icon-theme-name=Adwaita
    gtk-application-prefer-dark-theme=true
    gtk-button-images=true
    gtk-cursor-theme-size=24
    gtk-decoration-layout=icon:minimize,maximize,close
    gtk-enable-animations=true
    gtk-font-name=Noto Sans,  10
    gtk-menu-images=true
    gtk-modules=colorreload-gtk-module
    gtk-primary-button-warps-slider=false
    gtk-toolbar-style=3
    gtk-xft-dpi=98304

  '';
