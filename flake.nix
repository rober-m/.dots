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
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
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
    flake-compat,
    ...
  } @ inputs: let
    colorschemes = {
      cf = "catppuccin-frappe";
      cm = "catppuccin-macchiato";
      tns = "tokyo-night-storm";
      tnd = "tokyo-night-dark";
      od = "onedark";
      gdm = "gruvbox-dark-medium";
    };

    user-options = {
      username = "roberm";
      # More colorschemes at: https://github.com/tinted-theming/base16-schemes
      colorscheme = colorschemes.cf;
      opacity = 1; # Terminal-related opacity. Range: 0-1 (e.g., 0.92)
      fonts = ["Hack" "FiraCode" "DroidSansMono"];
    };
  in {
    darwinConfigurations =
      # Darwin Configurations
      import ./hosts/macbook16 {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin user-options;
      };

    nixosConfigurations =
      # NixOS Configurations
      import ./hosts/framework {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs-unstable home-manager user-options;
      };
  };
}
