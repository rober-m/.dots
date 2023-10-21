{pkgs, ...}: {
  services.touchegg.enable = true; # To detect trackpad's gesture animations in X11

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.vitals
    gnomeExtensions.x11-gestures # Only when using X11. Depends on touchegg service
    gnome3.gnome-tweaks
  ];

  environment.sessionVariables = {
    GTK_THEME = "Nordic:dark";
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Setting `dpi` breaks the sound in both X11 and Wayland!!
    #dpi = 180; # (200 is the actual one for the Framework)

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    displayManager.gdm.wayland = false;

    # Enable the KDE Plasma Desktop Environment.
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;

    # Configure keymap in X11
    layout = "us,es";
    # If xkb config doesn't seem to take effect, see:
    # https://discourse.nixos.org/t/problem-with-xkboptions-it-doesnt-seem-to-take-effect/5269/2
    xkbVariant = "";
    xkbOptions = "caps:swapescape";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };
}
