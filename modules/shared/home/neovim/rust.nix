{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = rustaceanvim;
        type = "lua";
        config =
          /*
          lua
          */
          ''
            ----------------------------- RUSTACEANVIM -----------------------------
          '';
      }
    ];
  };
  #extraPackages = with pkgs.vimPlugins; [
  #  # rust-analyzer # Rust language server (using rustup to install toolchain)
  #];
  home.file.".config/nvim/after/ftplugin/rust.lua".source = ./rust.lua;
}
