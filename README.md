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

### TODOs

- [ ] Add better instructions to README.
- [ ] Add secrets management.
- [ ] Should I expicitly import modules instead of using `default.nix` to make it easier to handle multiple systems?

## Installation

TODO: Add instructions

### If Neovim can't load packages

I'm not sure about this, but if Neovim has problems loading modules or finding packpath:
1. Install `vimPlugins.packer-nvim`
2. Run `:PackerInstall`
3. Rebuild

## Related docs
- [Nix language Manual](https://nixos.org/manual/nix/stable/)

- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/)

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki](https://nixos.wiki/wiki/Main_Page)
- [NixOS Options](https://nixos.org/manual/nixos/stable/options.html)

- [Nix-darwin](https://github.com/LnL7/nix-darwin)
- [Nix-darwin Options](https://daiderd.com/nix-darwin/manual/index.html)

- [Home Manager Manual](https://nix-community.github.io/home-manager)

## Inspiration

- [Matthias Benaets's config](https://github.com/MatthiasBenaets/nixos-config)
- [malob's config](https://github.com/malob/nixpkgs)
- [Srid's config](https://github.com/srid/nixos-config)
- [Misterio77's config](https://github.com/Misterio77/nix-config)
