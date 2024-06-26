# About fractional scaling:
# Fractional scaling using KDE in Wayland seems to be blurry. Although,
# avoiding fractional scaling and increasing font size seems to work.
# Try `plasma5.useQtScaling` if fractional scaling keeps giving problems.
{pkgs, ...}: {
  # environment.sessionVariables = {
  #  GTK_THEME = "Nordic:dark";
  #};

  services = {
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      # Enable the KDE Plasma Desktop Environment.
      defaultSession = "plasmawayland";
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      desktopManager.plasma5 = {
        enable = true;
        #useQtScaling = true; # TODO: Try this if fractional scaling keeps giving problems
      };

      # Configure keymap in X11
      # If xkb config doesn't seem to take effect, see:
      # https://discourse.nixos.org/t/problem-with-xkboptions-it-doesnt-seem-to-take-effect/5269/2
      xkb = {
        layout = "us,es";
        variant = "";
      };
      #xkbOptions = "caps:swapescape";
    };
  };

  # Exclude these packages from instalation
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    #elisa
    #gwenview
    #okular
    #oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
  ];
}
