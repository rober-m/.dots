{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    customized.haskell.enable = lib.mkEnableOption "Enable custom Haskell configuration";
  };

  config = lib.mkIf config.customized.haskell.enable {
    # Haskell packages
    home.packages = with pkgs; [
      # GHC VS boot libraries version: https://gitlab.haskell.org/ghc/ghc/-/wikis/commentary/libraries/version-history
      # INFO: Haskelll in Nix is a PITA. But I can't use ghcup cause it doesn't work on Nix.
      haskell.compiler.ghc965
      (haskell-language-server.override {supportedGhcVersions = ["965"];}) #Also installed in modules/nvim/lsp-config.nix

      haskellPackages.cabal-install
      haskellPackages.hoogle
      haskellPackages.ihaskell
      ihp-new # IHP framework (https://ihp.digitallyinduced.com/Guide/index.html)
      haskellPackages.doctest
      stylish-haskell # Haskell code prettifier / formatter
      ghciwatch # Load a GHCi session for a Haskell project and reloads it when source files change.
      zlib # Compression library. Needed to use Haskell's zlib package
      #haskellPackages.lhs2tex # Literate Haskell to LaTeX
      #ghcid # Dependency to compile Andres slides... for some reason..
    ];

    # Stack config
    # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
    home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
      templates = {
        scm-init = "git";
        params = {
          author-name = "Robertino Martinez"; # config.programs.git.userName;
          author-email = "48034748+rober-m@users.noreply.github.com"; # config.programs.git.userEmail;
          github-username = "rober-m";
        };
      };
      nix.enable = true;
    };

    # GHC config
    home.file.ghc = {
      target = ".ghci";
      text = ''
        :set prompt "λ: "
      '';
    };
  };
}
