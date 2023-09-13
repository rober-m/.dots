{
  description = "Robertino's darwin system";

  ###############################################################################################
  ######################################  INPUTS ################################################

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Other sources
    comma = {
      url = "github:Shopify/comma";
      flake = false;
    };

    # Nix tools
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ###############################################################################################
  ###################################### OUTPUTS ################################################

  outputs = {
    self,
    darwin,
    nixpkgs,
    home-manager,
    alejandra,
    ...
  } @ inputs: let
    inherit (inputs.nixpkgs-unstable.lib) attrValues optionalAttrs singleton;

    user = "roberm";
    location = "$HOME/.dots";
  in {
    darwinConfigurations = ( # Darwin Configurations
      import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin user attrValues optionalAttrs singleton self;
      }
    );
  };
}
