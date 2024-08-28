# TODO: Use this.
{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPluginFrom2Nix {
  pname = "avante";
  version = "0.0.0";
  src = fetchFromGitHub {
    owner = "yetone";
    repo = "avante.nvim";
    rev = "cadee677ba693ae527d5bc12b5ad5be94819074e";
    sha256 = "";
  };
  meta = with lib; {
    description = "Use your Neovim like using Cursor AI IDE!";
    homepage = "https://github.com/yetone/avante.nvim";
    license = licenses.apache20;
    maintainers = with maintainers; [rober-m];
  };
}
