{
  pkgs,
  user-options,
  ...
}: {
  imports = [
    ./base # base system (basic linux-systems configurations)
    ./nix.nix # Nix-related configurations
    ./gui # Graphical User Interface config (Desktop and WM)
    ./fingerprint.nix # Config to use fingerprint sensor
    ./flatpak.nix # Use flatpak
    ./android.nix # Android development tools
    ./cardano # Cardano-related tools/config
  ];

  #------------------------------------------------------------------------------------------------
  #----------------------------------- CUSTOMIZED PACKAGES ----------------------------------------

  # Most of these are in the `shared/home` config files.
  customized = {
    android.enable = true;
    cardano = {
      cardano-node.enable = false; # Run cardano-node as a service and install cardano-cli
      hydraw.enable = false; # Enable cardano-node (with cli) + hydra-node + example hydraw application
    };
  };

  #------------------------------------------------------------------------------------------------
  #----------------------------------- SYSTEM-LEVEL SERVICES ----------------------------------------

  virtualisation.docker.enable = true;
  services = {
    thermald.enable = true; # Enable thermald to prevent overheating.
    printing.enable = true; # Enable CUPS to print documents.
  };

  #------------------------------------------------------------------------------------------------
  #-------------------------- REST OF CONFIG (I HAVE TO TIDY A BIT) -------------------------------

  hardware = {
    bluetooth.enable = true; # Enable Bloetooth
    keyboard.zsa.enable = true; # Enable udev rules to flash new configurations to the ZSA Moonlander
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user-options.username} = {
    isNormalUser = true;
    description = "Robertino";
    extraGroups = ["networkmanager" "wheel" "docker" "adbusers"];
    shell = pkgs.zsh;
    # packages = with pkgs; [ ];
  };

  programs = {
    zsh.enable = true;
    #nix-index.enable = true;
    steam.enable = false; # Set to true if bored :P
  };
}
