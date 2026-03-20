# 🏗️ Architecture Overview

This document explains how the NixOS dotfiles repository is organized and how the different components work together.

## 📂 Directory Structure

```
nixos-dotfiles/
├── flake.nix                 # Main entry point - defines inputs and system configuration
├── flake.lock                # Locked versions of dependencies
│
├── hosts/                    # Host-specific configurations
│   └── nixos-btw/           # Configuration for the "nixos-btw" machine
│       ├── default.nix      # Host entry point - imports all host configs
│       ├── configuration.nix # Host-specific system settings (currently minimal)
│       ├── hardware-configuration.nix # Hardware-specific settings (auto-generated)
│       └── home.nix         # Home Manager configuration for this host
│
├── modules/                  # Reusable configuration modules
│   ├── nixos/               # System-level NixOS modules
│   │   ├── default.nix      # Imports all NixOS modules
│   │   ├── core.nix         # Core system settings (boot, networking, users)
│   │   ├── packages.nix     # System-wide packages and fonts
│   │   ├── services.nix     # System services (X11, audio, bluetooth, etc.)
│   │   ├── wallpapers.nix   # Custom wallpapers package
│   │   └── wallpapers/      # Wallpaper files
│   │
│   └── home-manager/        # User-level Home Manager modules
│       ├── default.nix      # Imports all Home Manager modules
│       ├── apps.nix         # User applications and tools
│       ├── git.nix          # Git and GitHub CLI configuration
│       ├── shell.nix        # Bash shell configuration
│       ├── devshell-scripts.nix  # Custom development shell scripts
│       └── devshell-scripts/     # Shell script implementations
│
└── config/                   # Application dotfiles (managed via Home Manager)
    ├── nvim/                # Neovim configuration
    ├── qtile/               # Qtile window manager configuration
    ├── rofi/                # Rofi launcher configuration
    ├── picom/               # Picom compositor configuration
    └── kitty/               # Kitty terminal configuration
```

## 🔄 Configuration Flow

### System Build Process

1. **Entry Point**: `flake.nix`
   - Defines NixOS and Home Manager as inputs
   - Creates `nixosConfigurations.nixos-btw` configuration

2. **Host Configuration**: `hosts/nixos-btw/default.nix`
   - Imports hardware configuration
   - Imports shared NixOS modules from `modules/nixos/`

3. **NixOS Modules**: `modules/nixos/`
   - **core.nix**: Boot loader, networking, timezone, users
   - **packages.nix**: System packages, fonts
   - **services.nix**: X11, audio (PipeWire), Bluetooth, Docker, etc.

4. **Home Manager**: Integrated in `flake.nix`
   - User configuration from `hosts/nixos-btw/home.nix`
   - Imports modules from `modules/home-manager/`

5. **Home Manager Modules**: `modules/home-manager/`
   - **apps.nix**: User packages and CLI tools
   - **git.nix**: Git and GitHub configuration
   - **shell.nix**: Bash prompt, aliases, environment variables

6. **Dotfiles**: Managed in `hosts/nixos-btw/home.nix`
   - Configs symlinked from `config/` to `~/.config/`

## 🎯 Design Principles

### Modularity
- Each module handles a specific domain (core system, packages, services, etc.)
- Modules are reusable across different hosts
- Easy to enable/disable features by commenting imports

### Separation of Concerns
- **System-level** (modules/nixos/): Requires root, affects all users
- **User-level** (modules/home-manager/): Per-user configuration
- **Host-specific** (hosts/): Machine-specific settings
- **Application configs** (config/): Dotfiles for specific programs

### Declarative Configuration
- Everything is defined in Nix expressions
- Reproducible across machines
- Version-controlled and atomic updates

## 🔌 Key Components

### Flakes
This configuration uses Nix flakes for:
- Dependency management (pinned versions in `flake.lock`)
- Reproducible builds
- Easy sharing and composition

### Home Manager
Manages user environment:
- User packages
- Dotfiles and configurations
- Shell environment
- Program-specific settings

### Custom Packages
- **wallpapers**: Custom package bundling wallpaper images
- **devshell-scripts**: Custom scripts for creating development environments

## 🚀 Adding New Features

### Add a System Package
Edit `modules/nixos/packages.nix`:
```nix
environment.systemPackages = with pkgs; [
  # ... existing packages
  your-new-package
];
```

### Add a User Package
Edit `modules/home-manager/apps.nix`:
```nix
home.packages = with pkgs; [
  # ... existing packages
  your-new-package
];
```

### Add a System Service
Edit `modules/nixos/services.nix`:
```nix
services.your-service = {
  enable = true;
  # ... configuration
};
```

### Add a New Module
1. Create `modules/nixos/your-module.nix` or `modules/home-manager/your-module.nix`
2. Add to respective `default.nix`:
```nix
imports = [
  # ... existing imports
  ./your-module.nix
];
```

## 🔍 Understanding the Build

When you run `sudo nixos-rebuild switch --flake .#nixos-btw`:

1. Nix reads `flake.nix`
2. Looks up `nixosConfigurations.nixos-btw`
3. Evaluates all imported modules
4. Builds the system closure
5. Activates the new configuration
6. Home Manager runs and sets up user environment

## 📚 Further Reading

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
