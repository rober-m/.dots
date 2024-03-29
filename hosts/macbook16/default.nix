{
  inputs,
  home-manager,
  darwin,
  user-options,
  ...
}: let
  system = "aarch64-darwin";

  nixpkgsWithConfig = {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };
  home-modules = {...}: {
    imports = [
      ../../modules/shared/home
      ../../modules/darwin/home
    ];
  };
in {
  # My `nix-darwin` configs
  macbook = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit user-options inputs;}; # Pass flake variables. These are available in all submodules (if indicated as inputs)
    modules = [
      # Shared system config
      ../../modules/shared/system
      # Main `nix-darwin` config
      ../../modules/darwin/nix-darwin
      # `home-manager` module
      home-manager.darwinModules.home-manager
      {
        nixpkgs = nixpkgsWithConfig;
        # `home-manager` config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user-options system inputs;}; # Pass flake variable
        home-manager.users.${user-options.username} = home-modules;
      }
    ];
  };
}
