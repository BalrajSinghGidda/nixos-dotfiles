{
  pkgs,
  lib,
  ...
}: {
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable DMS Greeter (Login System)
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/balraj";
  };

  # Ensure greetd is enabled so DMS greeter is started
  services.greetd.enable = true;
  services.greetd.settings.default_session.user = "greeter";

  nixpkgs.config.allowUnfree = true;

  # Flatpak support for additional app installation
  services.flatpak.enable = true;

  # Tailscale VPN service
  services.tailscale.enable = true;

  # Touchpad/trackpad support for laptops
  services.libinput.enable = true;

  # Power management and battery status
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Bluetooth MPRIS media control proxy
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # Docker container runtime (rootless mode for better security)
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true; # Set DOCKER_HOST environment variable
  };

  # Bluetooth hardware support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # Turn on Bluetooth on boot
  hardware.bluetooth.settings = {
    General = {
      Experimental = true; # Enable experimental features
    };
  };

  # Blueman GUI manager for Bluetooth
  services.blueman.enable = true;

  # Picom compositor (for transparency, shadows, animations)
  services.picom = {
    enable = true;
    backend = "glx"; # OpenGL backend for better performance
    vSync = true; # Prevent screen tearing
  };

  # SSH server for remote access
  services.openssh.enable = true;

  # Automatic system updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true; # Allow automatic reboots after updates

  # DMS can leave stale wallpaper files in its cache, which makes the greeter
  # pre-start script try to copy a file onto itself on the next boot.
  systemd.services.greetd.preStart = lib.mkBefore ''
    rm -f /var/lib/dms-greeter/wallpaper*
  '';

  # Enable XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    config.common.default = ["hyprland" "gtk" "*"];
    wlr.enable = true;
  };
}
