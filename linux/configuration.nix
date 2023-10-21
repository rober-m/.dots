{
  pkgs,
  user,
  ...
}: {
  imports = [
    ../common/configuration.nix # Common all-systems configuration
    ./modules/base # base system (basic linux-systems configurations)
    ./modules/gui # Graphical User Interface config (Desktop and WM)
    ./modules/fingerprint.nix # Config to use fingerprint sensor
  ];

  #################################################################################################
  ################################# NIXOS-SPECIFIC NIX CONFIG #####################################

  nix.gc.dates = "weekly";

  #################################################################################################
  ########################### REST OF CONFIG (I HAVE TO TIDY A BIT) ###############################

  virtualisation.docker.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable Bloetooth
  hardware = {
    bluetooth.enable = true;
    keyboard.zsa.enable = true; # Enable udev rules to be able to flash new configurations to the ZSA Moonlander
  };

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Robertino";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    # packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    alejandra
  ];

  programs = {
    zsh.enable = true;
    #nix-index.enable = true;
    steam.enable = false; # Set to true if bored :P
  };

  system.stateVersion = "23.05";
}
