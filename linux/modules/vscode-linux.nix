# Linux-specific config on top of `common/modules/vscode`
{pkgs, ...}: {
  #TODO: Add language servers (the ones in the nvim config) here? Add them to home.nix? Let VSCode manage the installation?
  programs.vscode.extensions = {
    extensions = with pkgs.vscode-extensions; [
      ms-vsliveshare.vsliveshare # Live Share (https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare)
    ];
  };
}
