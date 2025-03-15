{
  inputs,
  home-manager,
  user-options,
  nixpkgs,
  ...
}: let
  system = "x86_64-linux";

  nixpkgsWithConfig = {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };

    overlays = [
      (import ../../overlays/protonvpn-gui.nix)
    ];
  };
  home-modules = {...}: {
    imports = [
      ../../modules/shared/home
      ../../modules/linux/home
    ];
  };
in {
  # My `Framework` config
  framework = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs user-options system;}; # Pass flake variables. These are available in all submodules (if indicated as inputs)
    modules = [
      # Framework's hardware config
      ./hardware-configuration.nix
      # Shared system config
      ../../modules/shared/system
      # NixOS system config
      ../../modules/linux/nixos
      # `home-manager` modules
      home-manager.nixosModules.home-manager
      # `cardano-node` modules
      inputs.cardano-node.nixosModules.cardano-node
      # Custom hardware modules for 13th-gen Intel Framework Laptop
      inputs.nixos-hardware.nixosModules.framework-13th-gen-intel
      {
        nixpkgs = nixpkgsWithConfig;
        home-manager.useGlobalPkgs = false;
        home-manager.useUserPackages = false;
        home-manager.extraSpecialArgs = {inherit user-options inputs system;}; # Pass flake variables
        home-manager.users.${user-options.username} = home-modules;
        home-manager.backupFileExtension = "bakup";
      }
    ];
  };
}
