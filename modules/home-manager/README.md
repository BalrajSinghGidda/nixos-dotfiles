# Home Manager Modules

User-level configuration modules (no `sudo` required).

## Structure

### Tool Categories
- **cli-tools.nix** - Command-line utilities (ripgrep, yazi, eza, zoxide)
- **gui-apps.nix** - GUI applications (flatpak)
- **dev-tools.nix** - Development tools and programming languages

### Programs
- **programs/gemini-cli.nix** - Gemini AI CLI configuration
- **programs/nix-alien.nix** - nix-alien shell aliases (`na`, `nald`)

### Core Configuration
- **git.nix** - Git and GitHub CLI setup
- **shell.nix** - Bash environment (prompt, aliases, environment)

### Scripts
- **devshell-scripts.nix** - Custom development environment creation scripts
- **devshell-scripts/** - Script implementations

## Recent Changes

### nix-alien Integration (March 2026)
Added convenience aliases for running unpatched binaries:
- `na` - Short alias for `nix-alien`
- `nald` - Short alias for `nix-alien-ld`

The nix-alien package is installed at the system level, but user-friendly aliases are provided here.

## Making Changes

After editing any module, rebuild:

```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

Or use the alias:
```bash
nrs
```

See [docs/MODULE_GUIDE.md](../../docs/MODULE_GUIDE.md) for detailed documentation.
