{
  lib,
  fetchurl,
  stdenv,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "kanata";
  version = "1.7.0";

  src = fetchurl {
    url = "https://github.com/jtroo/kanata/releases/download/v${version}/kanata_macos_arm64";
    sha256 = "sha256-g62A+6+Mew7A4XBSoCygswV8u+r4oCOmFUHxUUqTa0M=";
  };

  dontUnpack = true;
  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/.kanata-unwrapped
    chmod +x $out/bin/.kanata-unwrapped
    makeWrapper $out/bin/.kanata-unwrapped $out/bin/kanata \
      --prefix PATH : ${stdenv.cc.cc.lib}/bin
  '';

  meta = with lib; {
    description = "Custom kanata installer from stand-alone executable in GitHub releases";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
