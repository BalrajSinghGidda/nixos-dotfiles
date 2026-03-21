# 🚀 NixOS Dotfiles - Balraj's Setup

> *"I use NixOS, btw"* - and here's the proof!

Welcome to my NixOS configuration! This is my personal setup running on a Dell Latitude 7490, featuring a sleek Qtile window manager with a Tokyo Night theme aesthetic. Built for coding, gaming, and general tech tinkering.

## 📚 Documentation

New to this repo? Start here:

- **[⚡ Quick Start Guide](docs/QUICK_START.md)** - Get up and running in minutes
- **[🏗️ Architecture Overview](docs/ARCHITECTURE.md)** - Understand how everything fits together
- **[📦 Module Guide](docs/MODULE_GUIDE.md)** - Deep dive into each configuration module

## 📂 Repository Structure

```
nixos-dotfiles/
├── flake.nix              # Main flake configuration
├── flake.lock             # Dependency lock file
│
├── hosts/                 # Host-specific configurations
│   └── nixos-btw/        # This machine's config
│       ├── default.nix          # Entry point
│       ├── hardware-configuration.nix
│       └── home.nix             # Home Manager config
│
├── modules/               # Reusable configuration modules
│   ├── nixos/            # System-level (requires sudo)
│   │   ├── core.nix            # Boot, networking, users
│   │   ├── packages.nix        # System packages & fonts
│   │   ├── services.nix        # System services
│   │   └── wallpapers.nix      # Custom wallpapers
│   │
│   └── home-manager/     # User-level (no sudo)
│       ├── apps.nix            # User packages
│       ├── git.nix             # Git configuration
│       ├── shell.nix           # Bash configuration
│       └── devshell-scripts.nix # Dev environment scripts
│
├── config/                # Application dotfiles
│   ├── nvim/             # Neovim configuration
│   ├── qtile/            # Qtile WM configuration
│   ├── rofi/             # Rofi launcher
│   ├── picom/            # Compositor
│   └── kitty/            # Terminal emulator
│
└── docs/                  # Documentation
    ├── ARCHITECTURE.md         # System architecture
    ├── QUICK_START.md          # Installation guide
    └── MODULE_GUIDE.md         # Module documentation
```

## 🎨 The Setup

**OS:** NixOS 25.05 (Stable)  
**WM:** Qtile  
**Terminal:** Kitty with Lilex Nerd Font  
**Editor:** Neovim (heavily customized)  
**Launcher:** Rofi  
**Compositor:** Picom  
**Theme:** Tokyo Night everywhere

## ✨ Features

- 🎯 **Declarative Configuration**: Everything is version-controlled and reproducible
- 🌊 **Flakes-Based**: Modern Nix flakes for dependency management
- 🏠 **Home Manager Integration**: User-level package and config management
- 🔧 **LSP-Powered Neovim**: Pre-configured for Lua, PHP, TypeScript, Rust, Zig, C/C++, Nix, Haskell, and more
- 🎨 **Consistent Theming**: Tokyo Night colors across all applications
- ⚡ **Performance Optimized**: Lightweight and snappy on a Dell Latitude 7490
- 🐳 **Docker Ready**: Rootless Docker setup included

## 📦 Key Applications

### Development
- **Neovim** with LSP, Treesitter, Telescope, and Harpoon
- **Kitty** terminal with custom Tokyo Night theme
- **Git** + **Lazygit** + **GitHub CLI**
- Language servers for multiple languages (no Mason, pure system packages!)
- **Zellij** and **Tmux** for terminal multiplexing

### Productivity
- **Firefox** as default browser
- **LibreOffice** suite
- **Rofi** for application launching
- **Yazi** terminal file manager
- Custom shell aliases for efficiency

### System Tools
- **Flatpak** support for additional apps
- **Tailscale** for secure networking
- **Blueman** for Bluetooth management
- **Dunst** for notifications
- Screenshot tools (Maim + Slop)

## 🎯 Quick Start

### For First-Time Users

1. **Read the documentation first:**
   - Start with [Quick Start Guide](docs/QUICK_START.md)
   - Understand the [Architecture](docs/ARCHITECTURE.md)
   - Review [Module Guide](docs/MODULE_GUIDE.md) for customization

2. **Clone and customize:**
```bash
git clone https://github.com/BalrajSinghGidda/nixos-dotfiles ~/nixos-dotfiles
cd ~/nixos-dotfiles
```

3. **Important: Update for your system:**
   - Copy your hardware config: `sudo cp /etc/nixos/hardware-configuration.nix hosts/nixos-btw/`
   - Update username in `hosts/nixos-btw/home.nix` and `modules/nixos/core.nix`
   - Update Git info in `modules/home-manager/git.nix`

4. **Apply the configuration:**
```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw
```

See the [Quick Start Guide](docs/QUICK_START.md) for detailed instructions!

## 🔥 Custom Aliases

I've set up some handy aliases that make life easier:

```bash
nc          # Open Neovim in nixos-dotfiles directory
btw         # Echo "I use NixOS, btw" (obviously)
nrs         # Rebuild NixOS system
edit-config # Edit system configuration
ls          # Enhanced ls with eza (icons, git status, etc.)
cd          # Smart directory jumping with zoxide
```

## ⌨️ Neovim Keybinds

My Neovim setup is highly customized. Here are some key bindings:

**Leader key:** `<Space>`

### Essential Binds
- `<leader>cd` - Open file explorer
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep
- `<leader>fb` - Browse buffers
- `<leader>a` - Add file to Harpoon
- `<C-e>` - Toggle Harpoon menu
- `<leader>u` - Toggle Undotree

### LSP
- `gd` - Go to definition
- `gr` - Show references
- `K` - Hover documentation
- `<F2>` - Rename symbol
- `<F3>` - Format code
- `<F4>` - Code actions

Check `config/nvim/README.md` for the complete keybind list!

## 🎨 Theme Customization

The Tokyo Night theme is applied consistently across:
- Qtile status bar and window decorations
- Kitty terminal colors
- Neovim syntax highlighting
- Rofi launcher

Want to change themes? Update the color schemes in:
- `config/kitty/kitty.conf`
- `config/nvim/lua/plugins/colors.lua`
- `config/rofi/tokyonight.rasi`
- `config/qtile/config.py`

## 🛠️ Development Environments

I use `direnv` for project-specific development environments. Create dev shells easily:

```bash
make-py-devshell   # Python development shell
make-cpp-devshell  # C++ development shell
```

## 📱 System Specs

My setup runs on:
- **Model:** Dell Latitude 7490
- **CPU:** Intel (with KVM support)
- **Storage:** NVMe SSD
- **Audio:** PipeWire + PulseAudio
- **Bluetooth:** Bluez with experimental features

## 🔧 Troubleshooting

### Rebuilding fails?
```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw --show-trace
```

### LSP not working?
Check if language servers are installed:
```bash
# Example for Lua
which lua-language-server

# Example for PHP
which intelephense
```

### Home Manager conflicts?
Home Manager creates backups with `.backup` extension. Check those files if configs aren't applying.

## 🛠️ Makefile Commands

This repo includes a Makefile for common tasks:

```bash
make switch   # Apply configuration
make test     # Test without switching
make build    # Build without activating
make update   # Update dependencies
make clean    # Remove old generations
make check    # Validate flake
make fmt      # Format Nix files
```

## 🤝 Contributing

Want to improve this configuration? Check out [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines!

Quick tips:
- Fork and customize for your own use
- Open issues for bugs or questions
- Submit PRs for improvements
- Keep changes focused and well-documented

## 📚 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Neovim LSP Config](https://github.com/neovim/nvim-lspconfig)
- [Qtile Documentation](http://docs.qtile.org/)

## 🤝 Contributing

Found something cool? Want to suggest improvements? Feel free to open an issue or PR!

## 📄 License

This is my personal configuration, but you're free to use, modify, and share it. No formal license - just have fun with it!

## 🎮 Fun Facts

- This config has been battle-tested through countless coding sessions
- The entire setup can be reproduced on any NixOS machine in minutes
- My terminal startup time shows `nitch` stats because why not? 😎
- The 80-column guide in Neovim keeps my code clean and readable

## 📞 Connect

- **GitHub:** [@AnonoyStar-Coder](https://github.com/AnonoyStar-Coder)
- **LinkedIn:** [Balraj Singh](https://linkedin.com/in/balraj-singh-259a75189)
- **X (Twitter):** [@Balraj77306947](https://x.com/Balraj77306947)
- **Bluesky:** [@balraj.link](https://bsky.app/profile/balraj.link)

---

Made with ❤️ and lots of ☕ by Balraj Singh Gidda

*P.S. Yes, I do use NixOS. And yes, I will tell you about it.* 😄