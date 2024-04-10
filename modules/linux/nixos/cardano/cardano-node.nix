{
  lib,
  config,
  ...
}: {
  options = {
    customized.cardano.cardano-node.enable = lib.mkEnableOption "Enable custom cardano-node service";
  };

  config = lib.mkIf config.customized.cardano.cardano-node.enable {
    services.cardano-node = {
      # Configuration options:
      # https://github.com/IntersectMBO/cardano-node/blob/c5d3d63b95b99c8000b5977948cb673dd89d28cc/nix/nixos/cardano-node-service.nix
      # Default DB path: /var/lib/cardano-node/db-<environment>
      enable = true;
      environment = "preview";
      # TODO: Add node configuration.
    };
  };
}
