## My personal dotfiles

This is the configuration for my machines:
- **MacBook Pro (M2)** with MacOS using `nix-darwin` and `home-manager`
- **Framework (Intel)** with NixOS using `home-manager`

Folder structure:
```
.dots
   ├─ modules (all modules)
   |   ├─ shared (modules shared between all systems)
   |   |    ├─ system (system-level config/modules)
   |   |    └─ home   (user-level config/modules)
   |   ├─ darwin (only Darwin/MacOS modules)
   |   |    ├─ nix-darwin
   |   |    └─ home
   |   └─ linux (only Linux/NixOS modules)
   |        ├─ nixos
   |        └─ home
   ├─ hosts (specific configurations for each machine)
   |   ├─ framework
   |   └─ macbook16
   ├─ overlays
   ├─ scripts
   └─ wallpapers
```

Folder dependency (higher depends on lower):
```
                    flake.nix
                       |
                     hosts
         --------------|--------------|
         |                            |
         |                            |
     macbook16                    framework
         |                            |
         |                            |
darwin (nix-darwin, home)     linux (NixOS, home)
         |                            |
         |                            |
         --------------|---------------
                shared (system, home)
```

### Roadmap

- [ ] ~~Solve: using X11 breaks touchpad gestures~~ (How: Using wayland now)
- [x] Add Neovim and configure all the essential packages
- [x] Create a sepparate config for Nvim + Haskell with: [haskell-tools](https://github.com/MrcJkb/haskell-tools.nvim)
- [x] Add VSCode + extensions
- [x] Add profiles for multiple systems
    - [x] MacOs + nix-darwin + home-manager
    - [x] NixOS + home-manager
- [ ] Rice NixOS
    - [ ] ~~Add XMonad to NixOS config~~
    - [x] Add a way to centralize colorscheme settings
- [x] Organize files in `hosts/*` and generalize `darwin` and `linux` config.
- [ ] Add better instructions to README.
- [ ] Should I expicitly import modules instead of using `default.nix` to make it easier to handle multiple systems?
- [x] Reestructure repo.
    

## Installation

TODO

### If Neovim can't load packages

I'm not sure about this, but if Neovim has problems loading modules or finding packpath:
1. Install `vimPlugins.packer-nvim`
2. Run `:PackerInstall`
3. Rebuild

## Inspiration

- [Matthias Benaets config](https://github.com/MatthiasBenaets/nixos-config)
