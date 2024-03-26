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
    xremap-flake.url = "github:xremap/nix-flake";
    cardano-node.url = "github:IntersectMBO/cardano-node/8.9.0";
    aiken_flake.url = "github:aiken-lang/aiken";

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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
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
    nixos-generators,
    cardano-node,
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
    ##################################################################
    ###################### Physical Machines ########################
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

    ##################################################################
    ################ Virtual Machines and Containers ################
    # See: https://github.com/nix-community/nixos-generators
    packages.x86_64-linux = {
      # Build with `nix build .#vmware-machine`
      vmware-machine = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          # you can include your own nixos configuration here, i.e.
          # ./configuration.nix
        ];
        format = "vmware";
      };
      # Build with `nix build .#vbox`
      vbox = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "virtualbox";
      };
    };
  };
}
