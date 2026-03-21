# 🚀 NixOS Dotfiles - Balraj's Setup

> *"I use NixOS, btw"* - and here's the proof!

Welcome to my NixOS configuration! This is my personal setup running on a Dell Latitude 7490, featuring a sleek Qtile window manager with a Tokyo Night theme aesthetic. Built for coding, gaming, and general tech tinkering.

## 🆕 Recent Updates (March 2026)

### Major Changes:
- **Neovim Migration to nvf**: Switched from manual Lua configuration to the nvf (Neovim framework) for declarative Neovim setup
- **nix-alien Integration**: Added support for running unpatched binaries with automatic library detection
- **Enhanced nix-ld**: Configured with 40+ common libraries for better non-NixOS binary compatibility
- **Removed config/nvim/**: All Neovim configuration now lives in `modules/nixos/nvf.nix`

See the [CHANGELOG.md](CHANGELOG.md) for detailed version history.

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
│   │   ├── core.nix            # Boot, networking, users, nix-ld
│   │   ├── packages.nix        # System packages & fonts
│   │   ├── services.nix        # System services
│   │   ├── nvf.nix             # Neovim (via nvf framework)
│   │   └── wallpapers.nix      # Custom wallpapers
│   │
│   └── home-manager/     # User-level (no sudo)
│       ├── cli-tools.nix       # CLI utilities
│       ├── gui-apps.nix        # GUI applications
│       ├── dev-tools.nix       # Development tools
│       ├── git.nix             # Git configuration
│       ├── shell.nix           # Bash configuration
│       └── programs/           # Program-specific configs
│           ├── gemini-cli.nix
│           └── nix-alien.nix
│
├── config/                # Application dotfiles
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
- 🔧 **nvf-Powered Neovim**: Declaratively configured via NixOS (no Mason, no manual Lua!)
- 🎨 **Consistent Theming**: Tokyo Night colors across all applications
- ⚡ **Performance Optimized**: Lightweight and snappy on a Dell Latitude 7490
- 🐳 **Docker Ready**: Rootless Docker setup included
- 👽 **nix-alien Support**: Run unpatched binaries with automatic library detection
- 📦 **nix-ld Integration**: 40+ system libraries for non-NixOS executables

## 📦 Key Applications

### Development
- **Neovim** configured via **nvf** (Neovim framework) with LSP, Treesitter, Telescope
- Language support: Python, TypeScript, C/C++, Go, Java, Bash, Nix, HTML, CSS, SQL, YAML, Markdown
- **Kitty** terminal with custom Tokyo Night theme
- **Git** + **Lazygit** + **GitHub CLI**
- **Zellij** and **Tmux** for terminal multiplexing
- **nix-alien** for running non-NixOS binaries (aliases: `na`, `nald`)

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

My Neovim is configured via **nvf** (Neovim framework). Configuration is in `modules/nixos/nvf.nix`.

**Key features:**
- File tree: nvim-tree
- Fuzzy finder: Telescope
- Git integration: Neogit + Lazygit
- Terminal: toggleterm (open with `,`)
- Auto-completion: nvim-cmp
- LSP with format-on-save

To customize keybinds or add plugins, edit `modules/nixos/nvf.nix` and rebuild.

## 🎨 Theme Customization

The Tokyo Night theme is applied consistently across:
- Qtile status bar and window decorations
- Kitty terminal colors
- Neovim (via nvf configuration)
- Rofi launcher

Want to change themes? Update the color schemes in:
- `config/kitty/kitty.conf`
- `modules/nixos/nvf.nix` (search for "tokyonight")
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

### Neovim LSP not working?
Neovim is configured via nvf. Check language settings in `modules/nixos/nvf.nix`.

Language servers are installed automatically. To verify:
```bash
which lua-language-server
which nil  # Nix LSP
```

### nix-alien not working?
Check if it's available:
```bash
nix-alien --version
# Or use aliases
na --version
nald --help
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