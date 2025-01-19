self: super: let
  version = "4.6.0";
in {
  protonvpn-gui = super.protonvpn-gui.overrideAttrs (
    attrs: {
      version = version;

      src = super.fetchFromGitHub {
        owner = "ProtonVPN";
        repo = "proton-vpn-gtk-app";
        rev = "refs/tags/v${version}";
        hash = "sha256-GCfr6x0KbIJr2r4UcFtMjuyHZVyDLKPvgtjdpTCb5Ro=";
      };
    }
  );
}
