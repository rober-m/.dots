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
    kanata.enable = true; # Run Kanata service with my own config
    android.enable = false; # Enable Android development tools
    hyprland.enable = false; # Enable custom hyprland+waybar configuration
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
    fwupd = {
      # Docs: https://github.com/NixOS/nixos-hardware/tree/master/framework
      enable = true; # Enable fwupd to update firmware.
      #extraRemotes = ["lvfs-testing"]; # Add the testing remote to get the latest firmware.
      # uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true; # Might be necessary once to make the update succeed
      #package =
      #  # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
      #  (import (builtins.fetchTarball {
      #      url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
      #      sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
      #    }) {
      #      inherit (pkgs) system;
      #    })
      #  .fwupd;
    };
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
    partition-manager.enable = true; # Enable KDE Partition Manager
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    ubuntu_font_family
  ];
}
