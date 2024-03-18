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
in {
  # My `Framework` config
  framework = nixpkgs-unstable.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs user-options;}; # Pass flake variables. These are available in all submodules (if indicated as inputs)
    modules = [
      # Main  config
      ./hardware-configuration.nix
      ../../linux/configuration.nix
      # `home-manager` module
      home-manager.nixosModules.home-manager
      {
        nixpkgs = nixpkgsWithConfig;
        # `home-manager` config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user-options inputs;}; # Pass flake variables
        home-manager.users.${user-options.username} = import ../../linux/home.nix;
      }
    ];
  };
}
