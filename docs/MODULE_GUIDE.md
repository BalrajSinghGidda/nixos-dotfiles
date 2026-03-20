# 📦 Module Guide

This guide explains each module in detail and how to customize them.

## 📑 Table of Contents

- [NixOS Modules](#nixos-modules)
  - [core.nix](#corenix)
  - [packages.nix](#packagesnix)
  - [services.nix](#servicesnix)
  - [wallpapers.nix](#wallpapersnix)
- [Home Manager Modules](#home-manager-modules)
  - [apps.nix](#appsnix)
  - [git.nix](#gitnix)
  - [shell.nix](#shellnix)
  - [devshell-scripts.nix](#devshell-scriptsnix)

---

## NixOS Modules

Located in `modules/nixos/` - These require `sudo` to modify and affect the entire system.

### core.nix

**Purpose**: Essential system configuration - boot, networking, users, and kernel modules.

**What it does**:
- Configures systemd-boot bootloader
- Sets hostname and enables NetworkManager
- Configures timezone
- Creates user accounts
- Enables Nix flakes
- Loads Dell-specific kernel modules

**Common customizations**:

```nix
# Change hostname
networking.hostName = "my-nixos-machine";

# Change timezone
time.timeZone = "America/New_York";

# Add a new user
users.users.newuser = {
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" ];
  packages = with pkgs; [ firefox chromium ];
};

# Add kernel modules
boot.kernelModules = [
  # ... existing modules
  "your-module"
];
```

**Dependencies**: None

---

### packages.nix

**Purpose**: System-wide packages and fonts available to all users.

**What it does**:
- Installs essential CLI tools (git, vim, neovim, etc.)
- Installs GUI applications (kitty, rofi, libreoffice)
- Installs development tools (direnv, lazygit, etc.)
- Configures system fonts (Nerd Fonts, etc.)
- Includes custom wallpapers package

**Package categories**:

```nix
# Essential tools
vim wget git gh

# Terminal & multiplexers
kitty zellij tmux

# Window manager & desktop
picom rofi xwallpaper feh

# Development
direnv lazygit redis

# Utilities
brightnessctl pamixer blueman dunst maim slop

# Productivity
libreoffice

# System monitoring
nitch
```

**Common customizations**:

```nix
# Add new packages
environment.systemPackages = with pkgs; [
  # ... existing packages
  vscode
  discord
  spotify
];

# Add new fonts
fonts.packages = with pkgs; [
  # ... existing fonts
  nerd-fonts.fira-code
  google-fonts
];

# Remove packages you don't need
# Just comment out or delete the line
```

**Dependencies**: `wallpapers.nix`

---

### services.nix

**Purpose**: System services and daemons - X11, audio, bluetooth, Docker, etc.

**What it does**:
- Enables X11 window system
- Configures Qtile window manager
- Sets up PipeWire (audio server)
- Enables PulseAudio compatibility
- Configures Bluetooth with experimental features
- Sets up rootless Docker
- Enables Flatpak support
- Configures Tailscale VPN

**Service breakdown**:

```nix
# Display server
services.xserver = {
  enable = true;
  xkb.layout = "us";
  windowManager.qtile = {
    enable = true;
    backend = "x11";
  };
};

# Audio stack
services.pipewire = {
  enable = true;
  alsa.enable = true;
  pulse.enable = true;
};

# Bluetooth
services.blueman.enable = true;
hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings.General.Experimental = true;
};

# Container runtime
virtualisation.docker = {
  enable = true;
  rootless = {
    enable = true;
    setSocketVariable = true;
  };
};

# VPN
services.tailscale.enable = true;

# Package management
services.flatpak.enable = true;
```

**Common customizations**:

```nix
# Switch to Wayland
services.xserver.enable = false;  # Disable X11
programs.wayland.enable = true;

# Change window manager to i3
services.xserver.windowManager.i3.enable = true;
services.xserver.windowManager.qtile.enable = false;

# Disable Bluetooth
hardware.bluetooth.enable = false;
services.blueman.enable = false;

# Enable printing
services.printing.enable = true;

# Enable SSH server
services.openssh = {
  enable = true;
  settings.PermitRootLogin = "no";
};

# Add more audio codecs
services.pipewire.extraConfig.pipewire."92-low-latency" = {
  context.properties = {
    default.clock.rate = 48000;
    default.clock.quantum = 32;
  };
};
```

**Dependencies**: None

---

### wallpapers.nix

**Purpose**: Custom package that bundles wallpaper images.

**What it does**:
- Creates a derivation containing wallpaper files
- Installs wallpapers to the Nix store
- Makes them available systemwide

**Structure**:
```nix
pkgs.stdenv.mkDerivation {
  name = "wallpapers";
  src = ./wallpapers/Pictures;
  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r $src/* $out/share/wallpapers/
  '';
}
```

**Usage**:
```bash
# Wallpapers are located at:
/nix/store/.../share/wallpapers/

# Set with feh
feh --bg-scale /nix/store/.../share/wallpapers/nix.png

# Or use xwallpaper
xwallpaper --zoom /path/to/wallpaper.png
```

**Adding wallpapers**:
1. Place images in `modules/nixos/wallpapers/Pictures/`
2. Rebuild system
3. Wallpapers are now in the Nix store

**Dependencies**: None (but used by `packages.nix`)

---

## Home Manager Modules

Located in `modules/home-manager/` - User-level configuration, no sudo required.

### apps.nix

**Purpose**: User packages and command-line tools.

**What it does**:
- Installs user-specific packages
- Configures Gemini CLI (AI assistant)
- Includes custom devshell scripts

**Package categories**:

```nix
home.packages = with pkgs; [
  # Code tools
  ripgrep nil nixpkgs-fmt nodejs gcc

  # File management
  yazi eza zoxide

  # Package management
  flatpak

  # Development
  python313Packages.euporie

  # Custom scripts
  devshell-scripts
];
```

**Gemini CLI configuration**:
```nix
programs.gemini-cli = {
  enable = true;
  settings = {
    theme = "Default";
    preferredEditor = "nvim";
    autoAccept = true;
  };
  defaultModel = "gemini-2.5-pro";
};
```

**Common customizations**:

```nix
# Add more packages
home.packages = with pkgs; [
  # ... existing packages
  neofetch
  htop
  btop
  
  # Language-specific tools
  rustc
  cargo
  go
  python311
];

# Configure Gemini CLI
programs.gemini-cli.settings = {
  theme = "Dark";
  defaultModel = "gemini-1.5-pro";
};

# Disable Gemini CLI
programs.gemini-cli.enable = false;
```

**Dependencies**: `devshell-scripts.nix`

---

### git.nix

**Purpose**: Git and GitHub CLI configuration.

**What it does**:
- Configures Git user identity
- Enables GitHub CLI (gh)
- Sets up git credential helper
- Configures gh preferences

**Current configuration**:
```nix
programs.git = {
  enable = true;
  settings = {
    user.name = "BalrajSinghGidda";
    user.email = "anonystargamerz@gmail.com";
  };
};

programs.gh = {
  enable = true;
  gitCredentialHelper.enable = true;
  settings = {
    git_protocol = "https";
    prompt = "enable";
    editor = "nvim";
  };
};
```

**Common customizations**:

```nix
# Update user info (REQUIRED for your setup!)
programs.git.settings = {
  user.name = "YourUsername";
  user.email = "your-email@example.com";
};

# Add Git aliases
programs.git.settings.alias = {
  st = "status";
  co = "checkout";
  br = "branch";
  ci = "commit";
  unstage = "reset HEAD --";
};

# Configure default branch
programs.git.settings.init.defaultBranch = "main";

# Add signing
programs.git.settings.commit.gpgsign = true;
programs.git.settings.user.signingkey = "YOUR_GPG_KEY";

# Use SSH for GitHub
programs.gh.settings.git_protocol = "ssh";
```

**Dependencies**: None

---

### shell.nix

**Purpose**: Bash shell environment - prompt, aliases, environment variables.

**What it does**:
- Configures Bash with completion
- Sets custom PS1 prompt
- Defines useful aliases
- Configures environment variables
- Integrates direnv and zoxide
- Shows nitch on startup

**Shell aliases**:
```nix
shellAliases = {
  nc = "nvim ~/nixos-dotfiles/.";
  btw = "echo I use NixOS, btw";
  nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw";
  edit-config = "nvim ~/nixos-dotfiles/configuration.nix";
  edit-home-config = "nvim ~/nixos-dotfiles/home.nix";
  ls = "eza --long -ahF --no-user --no-permissions --git --icons=always --color=always --grid";
  cd = "z";
  bm = "bashmount";
};
```

**Custom prompt**:
- Cyan username@hostname
- Green current directory
- Light blue prompt symbol

**Common customizations**:

```nix
# Add more aliases
shellAliases = {
  # ... existing aliases
  ll = "ls -la";
  ".." = "cd ..";
  gs = "git status";
  gp = "git push";
  gl = "git pull";
  nv = "nvim";
  update = "nix flake update ~/nixos-dotfiles && nrs";
};

# Customize prompt
bashrcExtra = ''
  # Starship prompt (alternative)
  eval "$(starship init bash)"
  
  # Or custom prompt
  export PS1="\[\e[1;32m\]\u@\h \[\e[1;34m\]\w \[\e[1;31m\]\$ \[\e[0m\]"
'';

# Add environment variables
bashrcExtra = ''
  export EDITOR="nvim"
  export VISUAL="nvim"
  export BROWSER="firefox"
  export PATH="$HOME/.local/bin:$PATH"
'';

# Remove nitch startup
# Just delete or comment out the 'nitch' line in bashrcExtra
```

**Dependencies**: None (uses eza and zoxide from `apps.nix`)

---

### devshell-scripts.nix

**Purpose**: Custom scripts for creating development environments.

**What it does**:
- Packages custom shell scripts
- Makes them available in PATH
- Provides commands for setting up dev environments

**Available scripts**:
- `make-py-devshell` - Python development environment
- `make-cpp-devshell` - C++ development environment
- `make-go-devshell` - Go development environment
- `make-java-devshell` - Java development environment
- `make-ruby-devshell` - Ruby development environment
- `make-rust-devshell` - Rust development environment

**Structure**:
```nix
pkgs.stdenv.mkDerivation {
  name = "devshell-scripts";
  src = ./devshell-scripts;
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
    chmod +x $out/bin/*
  '';
}
```

**Usage**:
```bash
# Create a Python project with dev environment
make-py-devshell my-python-project
cd my-python-project
direnv allow

# Create a Rust project
make-rust-devshell my-rust-project
```

**Adding new scripts**:
1. Create script in `modules/home-manager/devshell-scripts/`
2. Make it executable
3. Rebuild Home Manager

**Dependencies**: None (but scripts use direnv from `apps.nix`)

---

## 🔗 Module Dependencies

```
flake.nix
  ├── hosts/nixos-btw/default.nix
  │   ├── configuration.nix
  │   ├── hardware-configuration.nix
  │   └── modules/nixos/
  │       ├── core.nix
  │       ├── packages.nix (uses wallpapers.nix)
  │       ├── services.nix
  │       └── wallpapers.nix
  │
  └── home-manager
      ├── hosts/nixos-btw/home.nix
      └── modules/home-manager/
          ├── apps.nix (uses devshell-scripts.nix)
          ├── git.nix
          ├── shell.nix
          └── devshell-scripts.nix
```

## 🎯 Best Practices

1. **Keep modules focused**: Each module should handle one domain
2. **Comment your changes**: Future you will thank present you
3. **Test incrementally**: Make small changes and test frequently
4. **Use meaningful names**: If you split a module, name it descriptively
5. **Document customizations**: Add comments explaining why you made changes

## 🚀 Creating New Modules

### NixOS Module Template

```nix
# modules/nixos/my-module.nix
{ config, pkgs, ... }:

{
  # Your system-level configuration here
  environment.systemPackages = with pkgs; [
    # packages
  ];
  
  services.my-service = {
    enable = true;
    # configuration
  };
}
```

Then add to `modules/nixos/default.nix`:
```nix
{
  imports = [
    # ... existing imports
    ./my-module.nix
  ];
}
```

### Home Manager Module Template

```nix
# modules/home-manager/my-module.nix
{ config, pkgs, ... }:

{
  # Your user-level configuration here
  home.packages = with pkgs; [
    # packages
  ];
  
  programs.my-program = {
    enable = true;
    # configuration
  };
}
```

Then add to `modules/home-manager/default.nix`:
```nix
{
  imports = [
    # ... existing imports
    ./my-module.nix
  ];
}
```

---

Happy customizing! 🎉
