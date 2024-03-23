{
  pkgs,
  user-options,
  inputs,
  ...
}: {
  imports = [
    ../common/configuration.nix # Common all-systems configuration
    ./modules/base # base system (basic linux-systems configurations)
    ./modules/gui # Graphical User Interface config (Desktop and WM)
    ./modules/fingerprint.nix # Config to use fingerprint sensor
    ./modules/flatpak.nix # Use flatpak
    ./modules/android.nix # Android development tools
  ];

  #################################################################################################
  ################################# NIXOS-SPECIFIC NIX CONFIG #####################################

  system.stateVersion = "23.05";

  # Collect garbage every week
  nix.gc.dates = "weekly";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0";

  # Overlay to update MEGASync to the latest version
  nixpkgs.overlays = [
    (
      self: super: let
        version = "4.11.0.0";
        srcFlavor = "Linux";
      in {
        megasync = super.megasync.overrideAttrs (
          attrs: {
            version = version;

            src = super.fetchFromGitHub {
              owner = "meganz";
              repo = "MEGAsync";
              rev = "v${version}_${srcFlavor}";
              sha256 = "sha256-stL5qgnT141LZuaY7Bo0TqJVdCd9tB0xFQVmfxyYJU4=";
              fetchSubmodules = true;
            };

            buildInputs = attrs.buildInputs;
          }
        );
      }
    )
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

  #################################################################################################
  ########################### REST OF CONFIG (I HAVE TO TIDY A BIT) ###############################

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
    adb.enable = true; # Android Debug Bridge
  };
}
