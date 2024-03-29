{
  inputs,
  home-manager,
  user-options,
  nixpkgs-unstable,
  ...
}: let
  system = "x86_64-linux";

  nixpkgsWithConfig = {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };
  home-modules = {...}: {
    imports = [
      ../../modules/shared/home
      ../../modules/linux/home
    ];
  };
in {
  # My `Framework` config
  framework = nixpkgs-unstable.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs user-options;}; # Pass flake variables. These are available in all submodules (if indicated as inputs)
    modules = [
      # Framework's hardware config
      ./hardware-configuration.nix
      # Shared system config
      ../../modules/shared/system
      # NixOS system config
      ../../modules/linux/nixos
      # `home-manager` module
      home-manager.nixosModules.home-manager
      inputs.cardano-node.nixosModules.cardano-node
      {
        nixpkgs = nixpkgsWithConfig;
        # `home-manager` config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user-options inputs;}; # Pass flake variables
        #home-manager.users.${user-options.username} = (import ../../modules/shared/home) // (import ../../modules/linux/home);
        #home-manager.users.${user-options.username} = (import ../../modules/shared/home { inherit pkgs inputs user-options; }) // (import ../../modules/linux/home { inherit pkgs inputs user-options; });
        home-manager.users.${user-options.username} = home-modules;
      }
    ];
  };
}
