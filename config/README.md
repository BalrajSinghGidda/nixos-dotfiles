# Application Configurations

This directory contains dotfiles for various applications, managed by Home Manager.

## Applications

- **qtile/** - Qtile window manager configuration
- **rofi/** - Rofi launcher theme
- **picom/** - Picom compositor settings
- **kitty/** - Kitty terminal emulator configuration

## How It Works

These configurations are symlinked to `~/.config/` by Home Manager.

The linking is configured in `hosts/nixos-btw/home.nix`:

```nix
xdg.configFile."qtile".source = ../../config/qtile;
# etc...
```

## Making Changes

1. Edit files in this directory directly
2. For most applications, changes take effect immediately or on restart
3. For some applications, you may need to rebuild:
   ```bash
   nrs
   ```

## Adding New Application Config

1. Create a new directory: `config/myapp/`
2. Add your configuration files
3. Link it in `hosts/nixos-btw/home.nix`:
   ```nix
   xdg.configFile."myapp".source = ../../config/myapp;
   ```
4. Rebuild the system
