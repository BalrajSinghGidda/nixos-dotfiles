# 🚀 Migration to nixos-unstable

This guide walks you through migrating from NixOS 25.11 (stable) to nixos-unstable.

## What is nixos-unstable?

- **Stable (25.11)**: Tested, stable packages. Updated every ~6 months.
- **Unstable**: Latest packages, updated continuously. May have occasional issues.

## Why Migrate?

✅ Latest software versions
✅ Newest features and improvements  
✅ Faster security updates
⚠️ Slightly higher risk of breakage
⚠️ Need to monitor updates more carefully

## Migration Steps

### Step 1: Update flake.nix ✅ (DONE)

The flake.nix has been updated to use:
- `nixpkgs/nixos-unstable` instead of `nixpkgs/nixos-25.11`
- `home-manager/master` instead of `home-manager/release-25.11`

### Step 2: Update the flake lock

This downloads the new channel information:

```bash
cd ~/nixos-dotfiles
nix flake update
```

This will update `flake.lock` to point to unstable versions.

### Step 3: Test the new configuration

Build without switching (safe test):

```bash
sudo nixos-rebuild build --flake ~/nixos-dotfiles/#nixos-btw
```

Or use the Makefile:

```bash
make build
```

If there are no errors, proceed to Step 4.

### Step 4: Switch to unstable

Apply the new configuration:

```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

Or:

```bash
make switch
```

### Step 5: Reboot

```bash
sudo reboot
```

### Step 6: Verify

After reboot, check your NixOS version:

```bash
nixos-version
```

You should see something like `25.05.xxxxx` or higher (unstable doesn't have fixed versions).

## Potential Issues & Solutions

### Issue: Package not found

Some package names change between stable and unstable.

**Solution**: Check if the package was renamed:
```bash
nix search nixpkgs PACKAGE_NAME
```

### Issue: Build fails due to package conflicts

**Solution**: 
1. Check the error message carefully
2. Comment out problematic packages temporarily
3. Rebuild
4. Search for alternatives or updated package names

### Issue: Home Manager evaluation errors

**Solution**: Home Manager on master branch may have API changes.
Check the [Home Manager release notes](https://github.com/nix-community/home-manager/blob/master/CHANGELOG.md).

### Issue: System doesn't boot

**Solution**: Boot into previous generation from GRUB menu:
1. Restart and enter GRUB menu
2. Select "NixOS - All configurations"
3. Choose previous working generation
4. Boot into it
5. Roll back: `sudo nixos-rebuild switch --rollback`

## Rolling Back

If you want to go back to stable:

1. Edit `flake.nix` and change back to:
   ```nix
   nixpkgs.url = "nixpkgs/nixos-25.11";
   home-manager.url = "github:nix-community/home-manager/release-25.11";
   ```

2. Update and switch:
   ```bash
   nix flake update
   make switch
   ```

## Best Practices on Unstable

1. **Update regularly** - Don't let updates pile up
   ```bash
   make update && make switch
   ```

2. **Monitor for breakage** - Check NixOS Discourse for known issues

3. **Keep old generations** - Don't clean too aggressively
   ```bash
   # Keep last 30 days instead of 7
   sudo nix-collect-garbage --delete-older-than 30d
   ```

4. **Test before switching** - Always use `make build` or `make test` first

5. **Subscribe to updates** - Follow [@nixos_org](https://twitter.com/nixos_org) or [NixOS Discourse](https://discourse.nixos.org/)

## Current Status

- ✅ flake.nix updated to unstable
- ⏳ Ready for `nix flake update`
- ⏳ Ready to build and test
- ⏳ Ready to switch

## Quick Migration Commands

```bash
# Update to latest unstable
nix flake update

# Test the build
make build

# If successful, switch
make switch

# Reboot
sudo reboot
```

---

**Note**: The `system.stateVersion = "25.11"` in `core.nix` should NOT be changed. This tracks when you first installed NixOS, not which channel you're using.
