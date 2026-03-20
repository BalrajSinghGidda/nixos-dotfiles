{ pkgs, ... }:

let
  # Import custom wallpapers package
  wallpapers = (pkgs.callPackage ./wallpapers.nix {});
in
{
  # System-wide packages available to all users
  environment.systemPackages = with pkgs; [
    # Core utilities
    vim                 # Text editor
    wget                # File downloader
    nitch               # System info fetch tool
    git                 # Version control
    lazygit             # Terminal UI for git
    gh                  # GitHub CLI
    unzip               # Archive extraction
    
    # Terminal emulators & multiplexers
    kitty               # GPU-accelerated terminal
    zellij              # Modern terminal multiplexer
    tmux                # Traditional terminal multiplexer
    
    # Development tools
    neovim              # Modern Vim
    direnv              # Per-directory environment variables
    redis               # In-memory data store
    
    # Window manager & desktop environment
    picom               # Compositor for X11
    rofi                # Application launcher
    xwallpaper          # Wallpaper setter
    feh                 # Image viewer and wallpaper setter
    
    # System utilities
    brightnessctl       # Screen brightness control
    pamixer             # PulseAudio mixer
    udisks2             # Disk management
    eject               # Eject removable media
    libnotify           # Desktop notifications library
    dunst               # Notification daemon
    alsa-utils          # ALSA sound utilities
    libinput            # Input device management
    
    # Bluetooth management
    blueman             # Bluetooth manager GUI
    bluez               # Bluetooth stack
    
    # Screenshot tools
    maim                # Screenshot utility
    slop                # Screen region selector
    
    # X11 utilities
    xbindkeys           # Key binding utility
    xclip               # Clipboard utility
    xcb-util-cursor     # X11 cursor utilities
    
    # Productivity
    libreoffice         # Office suite
    
    # Custom packages
    wallpapers          # Custom wallpaper collection
  ];

  # Font configuration
  fonts.fontDir.enable = true;
  
  fonts.packages = with pkgs; [
    # Nerd Fonts (fonts with icons for terminal)
    nerd-fonts.jetbrains-mono
    nerd-fonts.lilex
    nerd-fonts.ubuntu
    
    # Microsoft fonts
    corefonts           # Arial, Times New Roman, etc.
    vista-fonts         # Calibri, Cambria, etc.
  ];
}
