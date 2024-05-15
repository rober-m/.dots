{
  description = "Yaci DevKit Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    packages.yaci-devkit = nixpkgs.mkPackage rec {
      pname = "yaci-devkit";
      version = "1.0.0"; # Update with the latest version

      src = nixpkgs.fetchurl {
        url = "https://github.com/bloxbean/yaci-devkit/releases/download/v${version}/${pname}-${version}.zip";
        sha256 = "<SHA256 hash of the archive>";
      };

      nativeBuildInputs = [nixpkgs.unzip];

      installPhase = ''
        mkdir -p $out/.yaci-devkit/bin
        mv ${pname}-${version}/* $out/.yaci-devkit
        ln -s $out/.yaci-devkit/bin/devkit.sh $out/.yaci-devkit/bin/devkit
        chmod +x $out/.yaci-devkit/bin/*.sh
      '';

      meta = with nixpkgs.lib; {
        description = "Yaci DevKit";
        homepage = "https://github.com/bloxbean/yaci-devkit";
        license = licenses.mit;
        maintainers = [maintainers.yourName]; # Put your name here
      };
    };
  };
}
