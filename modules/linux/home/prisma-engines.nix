{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    customized.prisma-engines.enable = lib.mkEnableOption "Enable custom prisma engines configuration";
  };

  config = lib.mkIf config.customized.prisma-engines.enable {
    home.packages = with pkgs; [
      #nodejs_20
      #nodePackages_latest.prettier
      prisma-engines
    ];

    programs.zsh = {
      profileExtra =
        /*
        bash
        */
        ''
          export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs.prisma-engines}/bin/schema-engine"
          export PRISMA_QUERY_ENGINE_BINARY="${pkgs.prisma-engines}/bin/query-engine"
          export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs.prisma-engines}/lib/libquery_engine.node"
          export PRISMA_FMT_BINARY="${pkgs.prisma-engines}/bin/prisma-fmt"
        '';
    };
  };
}
