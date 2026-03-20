{ pkgs, ... }:

{
  # X11 display server configuration
  services.xserver = {
    enable = true;
    # Keyboard repeat rate settings (faster repeat for better UX)
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    # Qtile tiling window manager
    windowManager.qtile.enable = true;
    # Set wallpaper on X11 startup
    displayManager.sessionCommands = ''
      xwallpaper --zoom /home/balraj/nixos-dotfiles/modules/nixos/wallpapers/Pictures/nix.png'';
  };

  # Ly display manager (minimal and aesthetic login screen)
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";  # Matrix-style animation
      bigclock = true;       # Show large clock on login
    };
  };

  # CUPS printing system
  services.printing.enable = true;
  # Canon printer drivers
  services.printing.drivers = [ pkgs.cnijfilter2 ];

  # PipeWire audio server (modern replacement for PulseAudio)
  services.pipewire = {
    enable = true;
    pulse.enable = true;  # PulseAudio compatibility
  };

  # Touchpad/trackpad support for laptops
  services.libinput.enable = true;

  # XDG Desktop Portal (for screen sharing, file pickers, etc.)
  xdg.portal = {
    enable = true;
    config.common.default = [ "*" ];
  };

  # Flatpak support for additional app installation
  services.flatpak.enable = true;

  # Tailscale VPN service
  services.tailscale.enable = true;

  # Bluetooth MPRIS media control proxy
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # Docker container runtime (rootless mode for better security)
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;  # Set DOCKER_HOST environment variable
  };

  # Bluetooth hardware support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;  # Turn on Bluetooth on boot
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;  # Enable experimental features
    };
  };

  # Blueman GUI manager for Bluetooth
  services.blueman.enable = true;

  # Picom compositor (for transparency, shadows, animations)
  services.picom = {
    enable = true;
    backend = "glx";  # OpenGL backend for better performance
    vSync = true;     # Prevent screen tearing
  };

  # SSH server for remote access
  services.openssh.enable = true;

  # Automatic system updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;  # Allow automatic reboots after updates
}
