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
      #(import ../../overlays/protonvpn-gui.nix)
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
    specialArgs = {inherit inputs user-options;}; # Pass flake variables. These are available in all submodules (if indicated as inputs)
    modules = [
      # Framework's hardware config
      ./hardware-configuration.nix
      # Shared system config
      ../../modules/shared/system
      # NixOS system config
      ../../modules/linux/nixos
      # `home-manager` modules
      home-manager.nixosModules.home-manager
      inputs.cardano-node.nixosModules.cardano-node
      {
        nixpkgs.overlays = [
          (_: _: {
            cardano-pkgs.node = inputs.cardano-node.packages.${system};
            #cardano-pkgs.aiken = inputs.aiken_flake_26.packages.${system}.aiken;
            #cardano-pkgs.aiken = inputs.aiken_bump_nix_pr.packages.${system}.aiken;
            cardano-pkgs.aiken = inputs.aiken_flake_asteria.packages.${system}.aiken;
            #cardano-pkgs.aiken = inputs.aiken_flake.packages.${system}.aiken;
          })
        ];
      }
      {
        nixpkgs = nixpkgsWithConfig;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user-options inputs;}; # Pass flake variables
        home-manager.users.${user-options.username} = home-modules;
      }
    ];
  };
}
