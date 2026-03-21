{ pkgs, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
  networking.hostName = "nixos-btw"; # Change this for your machine
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Asia/Kolkata";

  # Allow unfree packages (needed for some proprietary software)
  nixpkgs.config.allowUnfree = true;

  # Bash configuration
  programs.bash.completion.enable = true;
  programs.bash.blesh.enable = true; # Bash Line Editor SHell

  # Enable nix-ld for running unpatched binaries
  # nix-ld provides a dynamic linker and common libraries for non-NixOS executables
  # This is essential for running downloaded binaries, AppImages, and proprietary software
  programs.nix-ld = {
    enable = true;
    # Add common libraries that non-NixOS binaries might need
    # These libraries are symlinked to /run/current-system/sw/share/nix-ld/lib/
    libraries = with pkgs; [
      # C/C++ standard libraries
      stdenv.cc.cc.lib
      glibc
      
      # Common system libraries
      zlib
      zstd
      xz
      bzip2
      gzip
      
      # SSL/TLS
      openssl
      
      # X11 and graphics
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      libglvnd
      mesa
      
      # Audio
      alsa-lib
      libpulseaudio
      
      # Other common dependencies
      libcap
      attr
      acl
      fontconfig
      freetype
      dbus
      systemd
      
      # Development libraries
      curl
      expat
      libxml2
      
      # For running FHS binaries
      glib
      nspr
      nss
      util-linux
    ];
  };

  # Dell-specific kernel modules for proper hardware support
  boot.kernelModules = [
    "dell-wmi" # WMI driver for Dell laptops
    "dell-wmi-sysman" # System management
    "dell-smbios" # SMBIOS interface
    "dell-wmi-descriptor" # WMI descriptor
    "video" # Video driver
    "sparse-keymap" # Sparse keymap support
  ];

  # User account configuration - CHANGE 'balraj' to your username!
  users.users.balraj = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networking" ]; # wheel = sudo access
    packages = with pkgs; [
      tree # Directory tree visualization
    ];
  };

  # Enable Nix flakes and new nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NixOS state version - DON'T change after initial installation
  # This is the version you initially installed, not the channel you're using
  system.stateVersion = "25.11";
}
