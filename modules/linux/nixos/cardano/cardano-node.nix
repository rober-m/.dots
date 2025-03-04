{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    customized.cardano.cardano-node.enable = lib.mkEnableOption "Enable custom cardano-node service and install cardano-cli";
  };

  config = lib.mkIf config.customized.cardano.cardano-node.enable {
    environment.systemPackages = with pkgs; [
      cardano-pkgs.node.cardano-cli
    ];
    environment.sessionVariables = {
      CARDANO_NODE_SOCKET_PATH = "/run/cardano-node/node.socket";
      CARDANO_NODE_NETWORK_ID = (
        let
          cases = {
            "preview" = "2";
            "preprod" = "3";
          };
          lookup = attrs: key: default:
            if attrs ? key
            then attrs."${key}"
            else default;
        in
          lookup config.services.cardano-node.environment cases "2"
      );
    };
    services.cardano-node = {
      # Configuration options:
      # https://github.com/IntersectMBO/cardano-node/blob/c5d3d63b95b99c8000b5977948cb673dd89d28cc/nix/nixos/cardano-node-service.nix
      # Default DB path: /var/lib/cardano-node/db-<environment>
      enable = true;
      environment = "preview";
      # Change socket path to avoid sudo?
      # Add node configuration here.
    };
  };
}
