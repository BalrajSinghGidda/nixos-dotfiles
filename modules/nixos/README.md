# NixOS Modules

System-level configuration modules that require `sudo` to modify.

## Modules

- **core.nix** - Essential system settings (boot, networking, users, timezone, nix-ld)
- **packages.nix** - System-wide packages and fonts
- **services.nix** - System services (X11, audio, Bluetooth, Docker, etc.)
- **nvf.nix** - Neovim configuration using the nvf framework
- **wallpapers.nix** - Custom wallpapers package

## Recent Changes

### Neovim Migration (March 2026)
The Neovim configuration has been migrated from manual Lua configuration to the **nvf** (Neovim configuration framework):
- Removed `config/nvim/` directory with Lua files
- Added `nvf.nix` module for declarative Neovim configuration
- All plugins and LSP servers now managed through NixOS
- Configuration is more maintainable and reproducible

### nix-ld Enhancement
The `core.nix` module now includes extensive nix-ld library support:
- 40+ common libraries for running non-NixOS binaries
- Graphics, audio, SSL/TLS, and development libraries included

## Making Changes

After editing any module, rebuild the system:

```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

See [docs/MODULE_GUIDE.md](../../docs/MODULE_GUIDE.md) for detailed documentation.
