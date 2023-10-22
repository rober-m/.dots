## My personal dotfiles

This is the configuration for my machines:
- **MacBook Pro (M2)** with MacOS using `nix-darwin` and `home-manager`
- **Framework (Intel)** with NixOS using `home-manager`

Folder dependency (higher depends on lower):
```
              flake.nix
                  |
                hosts
        ----------|--------|
        |                  |
    macbook16          framework
        |                  |
      darwin             linux
        |                  |
        ----------|---------
                common
```

### Roadmap

- [ ] Solve: using X11 breaks touchpad gestures
- [x] Add Neovim and configure all the essential packages
- [x] Create a sepparate config for Nvim + Haskell with: [haskell-tools](https://github.com/MrcJkb/haskell-tools.nvim)
- [x] Add VSCode + extensions
- [x] Add profiles for multiple systems
    - [x] MacOs + nix-darwin + home-manager
    - [x] NixOS + home-manager
- [ ] Rice NixOS
    - [ ] Add XMonad to NixOS config
    - [ ] Add a way to centralize colorscheme settings
- [x] Organize files in `hosts/*` and generalize `darwin` and `linux` config.
- [ ] Add better instructions to README.
- [ ] Should I expicitly import modules instead of using `default.nix` to make it easier to handle multiple systems?

## Installation

TODO

### If Neovim can't load packages

I'm not sure about this, but if Neovim has problems loading modules or finding packpath:
1. Install `vimPlugins.packer-nvim`
2. Run `:PackerInstall`
3. Rebuild
