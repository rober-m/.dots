{
  pkgs,
  user-options,
  inputs,
  ...
}: {
  imports = [
    ./base # base system (basic linux-systems configurations)
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
      cardano-node.enable = true; # Run cardano-node as a service
    };
  };
  #------------------------------------------------------------------------------------------------
  #-------------------------------- NIXOS-SPECIFIC NIX CONFIG -------------------------------------

  system.stateVersion = "23.05";

  # Collect garbage every week
  nix.gc.dates = "weekly";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0";

  # Overlay to update MEGASync to the latest version
  nixpkgs.overlays = [
    (import ../../../overlays/magasync.nix)
  ];

  # Auto-upgrade system
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "weekly";
    randomizedDelaySec = "1d";
  };

  #------------------------------------------------------------------------------------------------
  #-------------------------- REST OF CONFIG (I HAVE TO TIDY A BIT) -------------------------------

  virtualisation.docker.enable = true;

  services.thermald.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  environment.systemPackages = with pkgs; [
    wget
    alejandra
  ];

  programs = {
    zsh.enable = true;
    #nix-index.enable = true;
    steam.enable = false; # Set to true if bored :P
  };
}
