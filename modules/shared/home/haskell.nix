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
      #haskell.compiler.ghc810 #(GHC: 8.10.7 && base: 4.14.3.0)
      haskell.compiler.ghc925 #(GHC: 9.2.5  && base: 4.16.4.0)
      #haskell.compiler.ghc928 #(GHC: 9.2.6  && base: 4.16.4.0)
      #haskell.compiler.ghc942 #(GHC: 9.4.2  && base: 4.17.0.0)
      #haskell.compiler.ghc96 #(GHC: 9.6.2  && base: 4.18.0.0)
      (haskell-language-server.override {supportedGhcVersions = ["925"];}) #Also installed in modules/nvim/lsp-config.nix
      #(haskell-language-server.override {supportedGhcVersions = ["810"];}) #Also installed in modules/nvim/lsp-config.nix
      haskellPackages.cabal-install
      haskellPackages.hoogle
      haskellPackages.ihaskell
      ihp-new # IHP framework (https://ihp.digitallyinduced.com/Guide/index.html)
      haskellPackages.doctest
      stylish-haskell # Haskell code prettifier / formatter
      #haskellPackages.lhs2tex # Literate Haskell to LaTeX
      #ghcid # Dependency to compile Andres slides... for some reason..
      zlib # Compression library. Needed to use Haskell's zlib package
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
