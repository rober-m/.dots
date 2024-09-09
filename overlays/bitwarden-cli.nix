self: super: let
  version = "2024.8.0";
in {
  bitwarden-cli = super.bitwarden-cli.overrideAttrs (
    attrs: {
      version = version;

      src = super.fetchFromGitHub {
        rev = "cli-v${version}";
        sha256 = "sha256-stL5qgnT141LZuaY7Bo0TqJVdCd9tB0xFQVmfxyYJU4=";
      };

      buildInputs = attrs.buildInputs;
    }
  );
}
