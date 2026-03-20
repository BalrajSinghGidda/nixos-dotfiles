# ⚡ Quick Start Guide

Get up and running with this NixOS configuration in minutes!

## 🎯 Prerequisites

Before you begin, ensure you have:

- ✅ NixOS installed (tested on 25.11)
- ✅ Git installed
- ✅ Basic familiarity with terminal commands
- ✅ Admin (sudo) access

## 📥 Installation Steps

### 1. Backup Your Current Configuration

```bash
# Backup your current NixOS configuration
sudo cp -r /etc/nixos /etc/nixos.backup

# Backup your home directory configs (optional but recommended)
cp -r ~/.config ~/.config.backup
```

### 2. Clone This Repository

```bash
# Clone to your home directory
git clone https://github.com/BalrajSinghGidda/nixos-dotfiles ~/nixos-dotfiles
cd ~/nixos-dotfiles
```

### 3. Review and Customize

**Important**: Before applying, customize these files for your system:

#### Edit Host-Specific Settings

```bash
# Copy your hardware configuration
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-dotfiles/hosts/nixos-btw/

# Edit host settings if needed
nvim hosts/nixos-btw/configuration.nix
```

#### Update User Information

Edit `modules/home-manager/git.nix`:
```nix
user.name = "YourGitHubUsername";
user.email = "your-email@example.com";
```

Edit `modules/nixos/core.nix`:
```nix
users.users.balraj = {  # Change 'balraj' to your username
  isNormalUser = true;
  extraGroups = [ "wheel" "networking" ];
};
```

Edit `hosts/nixos-btw/home.nix`:
```nix
home.username = "your-username";
home.homeDirectory = "/home/your-username";
```

#### Update Hostname (Optional)

Edit `modules/nixos/core.nix`:
```nix
networking.hostName = "your-hostname";  # Change from "nixos-btw"
```

If you change the hostname, also update `flake.nix`:
```nix
nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
  # ...
};
```

### 4. Test the Configuration

```bash
# Dry-run to check for errors (doesn't apply changes)
sudo nixos-rebuild dry-build --flake ~/nixos-dotfiles/#nixos-btw
```

### 5. Apply the Configuration

```bash
# Apply the configuration
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

This will:
- Install all system packages
- Configure system services
- Set up Home Manager
- Link dotfiles to ~/.config

### 6. Reboot (Recommended)

```bash
sudo reboot
```

## 🎨 First Login

After reboot, you should see:

1. **Login screen** - Log in with your user credentials
2. **Qtile WM** - Tiled window manager with Tokyo Night theme
3. **Terminal** - Opens Kitty with custom theme
4. **System info** - `nitch` displays on shell startup

## 🔧 Post-Installation

### Test Key Features

```bash
# Test Neovim
nvim

# Test file manager
yazi

# Test launcher (press: Mod + p in Qtile)
# Rofi should appear

# Check Git configuration
git config --list

# Test development shell creation
make-py-devshell my-project
```

### Verify Services

```bash
# Check PipeWire audio
pactl info

# Check Bluetooth
bluetoothctl show

# Check Docker (rootless)
docker ps
```

## 📝 Making Changes

### Update System Configuration

```bash
# Edit any .nix file
nvim ~/nixos-dotfiles/modules/nixos/packages.nix

# Apply changes
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

### Update User Configuration

```bash
# Edit home-manager files
nvim ~/nixos-dotfiles/modules/home-manager/apps.nix

# Apply changes (same command as system)
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

### Update Dotfiles

```bash
# Edit application configs
nvim ~/nixos-dotfiles/config/kitty/kitty.conf

# Changes apply immediately (or restart the application)
```

## 🚀 Useful Aliases

This configuration includes helpful aliases:

```bash
nc          # Quick edit nixos-dotfiles in Neovim
nrs         # Rebuild NixOS system
btw         # Echo "I use NixOS, btw"
ls          # Enhanced ls with icons and git status
cd          # Smart directory navigation with zoxide
```

## ❓ Common Issues

### Issue: "error: flake not found"

**Solution**: Make sure you're in the correct directory or use full path:
```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

### Issue: Home Manager file conflicts

**Solution**: Home Manager creates backups. Check `*.backup` files:
```bash
ls ~/.config/*.backup
```

Remove or merge conflicts, then rebuild.

### Issue: Graphics/display issues

**Solution**: Your hardware config may need adjustment:
```bash
# Copy your original hardware config
sudo cp /etc/nixos.backup/hardware-configuration.nix ~/nixos-dotfiles/hosts/nixos-btw/
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

### Issue: Permission denied for Docker

**Solution**: Add yourself to docker group (already in services.nix):
```bash
# Re-login or run:
newgrp docker
```

## 🔄 Rolling Back

If something goes wrong:

```bash
# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Or boot into previous generation from bootloader
sudo reboot
# Select older generation from systemd-boot menu
```

## 📚 Next Steps

- Read [ARCHITECTURE.md](./ARCHITECTURE.md) to understand the structure
- Check [MODULE_GUIDE.md](./MODULE_GUIDE.md) for customization details
- Explore individual configs in `config/` directories
- Join the NixOS community: [Discourse](https://discourse.nixos.org/), [Reddit](https://reddit.com/r/nixos)

## 💡 Tips

1. **Keep it in Git**: Always commit changes before rebuilding
2. **Test before switching**: Use `nixos-rebuild test` for temporary changes
3. **Update regularly**: Run `nix flake update` to update dependencies
4. **Read error messages**: Nix errors are detailed and usually helpful
5. **Start small**: Make incremental changes and test frequently

---

🎉 **Congratulations!** You're now running a fully declarative NixOS setup!
