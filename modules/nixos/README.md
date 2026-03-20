# NixOS Modules

System-level configuration modules that require `sudo` to modify.

## Modules

- **core.nix** - Essential system settings (boot, networking, users, timezone)
- **packages.nix** - System-wide packages and fonts
- **services.nix** - System services (X11, audio, Bluetooth, Docker, etc.)
- **wallpapers.nix** - Custom wallpapers package

## Making Changes

After editing any module, rebuild the system:

```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

See [docs/MODULE_GUIDE.md](../../docs/MODULE_GUIDE.md) for detailed documentation.
