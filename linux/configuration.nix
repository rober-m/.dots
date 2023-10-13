# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, user, ... }:

{

  imports = [ 
    ../common/nixconf.nix # Common nix configuration
    #./xmonad.nix # window manager
    #./modules/system-wide-gtk.nix
    ./modules/fingerprint.nix
  ];

  #################################################################################################
  ################################# NIXOS-SPECIFIC NIX CONFIG #####################################

  nix.gc.dates = "weekly";

  #################################################################################################
  ########################### REST OF CONFIG (I HAVE TO TIDY A BIT) ###############################

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker = {
    enable = true;
   # daemon.settings = {
   #   #ipv6 = false;
   #   dns = [ "1.1.1.1" "8.8.8.8" ];
   #  # proxies = {
   #  #   "http-proxy" = ":ttp://";
   #     "http-proxy" = "";
   #  #   "https-proxy" = "";
   #  #   "no-proxy" = "*";
   #  # };
   # };
  };

  networking = {
    hostName = "framework"; # Define your hostname.
    enableIPv6 = false; # It might be causing "Host/Server Not Found" errors.
    nameservers = [ "1.1.1.1"]; # 1.1.1.1 is Clodflare DNS. 8.8.8.8 is Google Public DNS.
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
    # Enable networking
    networkmanager.enable = true;

  };

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    #dpi = 180; # 200 is the actual one # This breaks sound?

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    #displayManager.gdm.wayland = true;

    # Enable the KDE Plasma Desktop Environment.
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;

    # Configure keymap in X11
    layout = "us,es";
    # If xkb config doesn't seem to take effect, see:
    # https://discourse.nixos.org/t/problem-with-xkboptions-it-doesnt-seem-to-take-effect/5269/2
    xkbVariant = "";
    xkbOptions = "caps:swapescape"; 
  };



  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable Bloetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Robertino";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    # packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "nvim";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #neovim 
    wget
    gnomeExtensions.appindicator
    gnome3.gnome-tweaks
  ];

  environment.sessionVariables = {
    GTK_THEME = "Nordic:dark";
  };

  programs = {
    zsh.enable = true;
    #nix-index.enable = true;
    steam.enable = false; # Set to true if bored :P
  };

  system.stateVersion = "23.05";
}
