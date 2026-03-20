# Contributing to NixOS Dotfiles

First off, thanks for taking the time to contribute! 🎉

## For New Users

If you're new to this repository:

1. **Read the documentation**
   - [Quick Start Guide](docs/QUICK_START.md)
   - [Architecture Overview](docs/ARCHITECTURE.md)
   - [Module Guide](docs/MODULE_GUIDE.md)

2. **Understand the structure**
   - `hosts/` - Host-specific configurations
   - `modules/nixos/` - System-level modules
   - `modules/home-manager/` - User-level modules
   - `config/` - Application dotfiles

## Making Changes

### For Your Own Fork

1. **Clone and customize**
   ```bash
   git clone https://github.com/YOUR_USERNAME/nixos-dotfiles ~/nixos-dotfiles
   cd ~/nixos-dotfiles
   ```

2. **Update personal information**
   - Change username in `hosts/nixos-btw/home.nix` and `modules/nixos/core.nix`
   - Update Git info in `modules/home-manager/git.nix`
   - Copy your hardware config: `sudo cp /etc/nixos/hardware-configuration.nix hosts/nixos-btw/`

3. **Test your changes**
   ```bash
   make build  # Test build without applying
   make test   # Test without making it permanent
   make switch # Apply permanently
   ```

### For Contributing Back

1. **Fork the repository**

2. **Create a feature branch**
   ```bash
   git checkout -b feature/my-awesome-feature
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add comments for complex configurations
   - Update documentation if needed

4. **Test thoroughly**
   ```bash
   make check  # Validate flake
   make build  # Test build
   ```

5. **Commit with clear messages**
   ```bash
   git commit -m "Add: Feature description"
   ```

   Use prefixes:
   - `Add:` - New feature
   - `Fix:` - Bug fix
   - `Update:` - Update existing feature
   - `Docs:` - Documentation changes
   - `Refactor:` - Code restructuring

6. **Push and create Pull Request**
   ```bash
   git push origin feature/my-awesome-feature
   ```

## Code Style

### Nix Files

- Use 2 spaces for indentation
- Add comments for non-obvious configurations
- Group related settings together
- Keep modules focused on single responsibilities

Example:
```nix
{ pkgs, ... }:

{
  # Audio configuration
  services.pipewire = {
    enable = true;
    pulse.enable = true;  # PulseAudio compatibility
  };
}
```

### Comments

- Explain **why**, not **what** (the code shows what)
- Add comments for hardware-specific tweaks
- Document any workarounds or hacks

## Module Guidelines

### Creating New Modules

1. **Keep it focused** - One module = One domain
2. **Make it reusable** - Avoid hardcoding user-specific values
3. **Document it** - Add comments and update MODULE_GUIDE.md
4. **Test it** - Ensure it builds and works

### Module Template

```nix
# modules/nixos/my-feature.nix
{ config, pkgs, ... }:

{
  # Brief description of what this module does
  
  # Group related configurations
  services.my-service = {
    enable = true;
    # Add inline comments for complex settings
    setting = "value";
  };
}
```

## Submitting Issues

### Bug Reports

Include:
- NixOS version (`nixos-version`)
- Steps to reproduce
- Expected vs actual behavior
- Error messages (if any)

### Feature Requests

Include:
- Clear description of the feature
- Use case / motivation
- Examples from other configs (if applicable)

## Questions?

- Open an issue for configuration questions
- Check existing issues and PRs first
- Be respectful and patient

## License

By contributing, you agree that your contributions will be included under the same terms as the original repository.

---

Thank you for contributing! 🚀
