{
  description = "Robertino's systems";

  ###############################################################################################
  ######################################  INPUTS ################################################

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Other sources
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xmonad-contexts = {
      url = "github:Procrat/xmonad-contexts";
      flake = false;
    };

    # Nix tools
    flake-utils.url = "github:numtide/flake-utils"; # TODO: use this.
    nix-colors.url = "github:misterio77/nix-colors";
    comma = {
      url = "github:Shopify/comma";
      flake = false;
    };
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
    nixpkgs-unstable,
    home-manager,
    alejandra,
    flake-utils,
    ...
  } @ inputs: let
    user = "roberm";
    # More colorschemes at: https://base16-showcase.vercel.app/
    colorscheme = "tokyo-night-dark"; # tokyo-night-storm/-dark | gruvbox-dark-medium/hard | nord | mocha | onedark
  in {
    darwinConfigurations =
      # Darwin Configurations
      import ./hosts/macbook16 {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin user colorscheme;
      };

    nixosConfigurations =
      # NixOS Configurations
      import ./hosts/framework {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs-unstable home-manager user colorscheme;
      };
  };
}
