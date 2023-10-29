{
  inputs,
  home-manager,
  darwin,
  user-options,
  ...
}: let
  system = "aarch64-darwin";

  nixpkgsWithConfig = {
    config = {allowUnfree = true;};
  };
in {
  # My `nix-darwin` configs
  macbook = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit user-options inputs;}; # Pass flake variables. These are available in all submodules (if indicated as inputs)
    modules = [
      # Main `nix-darwin` config
      ../../darwin/configuration.nix
      # `home-manager` module
      home-manager.darwinModules.home-manager
      {
        nixpkgs = nixpkgsWithConfig;
        # `home-manager` config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user-options system inputs;}; # Pass flake variable
        home-manager.users.${user-options.username} = import ../../darwin/home.nix;
      }
    ];
  };
}
