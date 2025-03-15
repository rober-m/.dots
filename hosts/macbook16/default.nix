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
        nixpkgs.overlays = [
          (_: _: {
            #cardano-pkgs.aiken = inputs.aiken_flake_1_1_0.packages.${system}.aiken; # Installed with `nix profile`
            superfile = inputs.superfile.packages.${system}.default;
          })
          (self: super: {
            # https://github.com/LnL7/nix-darwin/issues/1041
            karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
              version = "14.13.0";

              src = super.fetchurl {
                inherit (old.src) url;
                hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
              };
            });
          })
        ];
      }
      {
        nixpkgs = nixpkgsWithConfig;
        # `home-manager` config
        home-manager.useGlobalPkgs = false;
        home-manager.useUserPackages = false;
        home-manager.extraSpecialArgs = {inherit user-options system inputs;}; # Pass flake variable
        home-manager.users.${user-options.username} = home-modules;
        home-manager.backupFileExtension = "bakup";
      }
    ];
  };
}
