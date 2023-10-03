{
  inputs,
  home-manager,
  user,
  nixpkgs-unstable,
  ...
}: let
  system = "x86_64-linux";

  nixpkgsWithConfig = {
    config = {allowUnfree = true;};
  };
in {
  # My `NixOS` configs
  framework = nixpkgs-unstable.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit user inputs;}; # Pass flake variables. These are available in all submodules (if indicated as inputs)
    modules = [
      # Main  config
      ./configuration.nix
      # `home-manager` module
      home-manager.nixosModules.home-manager
      {
        nixpkgs = nixpkgsWithConfig;
        # `home-manager` config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user inputs;}; # Pass flake variable
        home-manager.users.${user} = import ./home.nix;
      }
    ];
  };
}
