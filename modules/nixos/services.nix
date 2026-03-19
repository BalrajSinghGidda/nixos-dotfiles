{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
      xwallpaper --zoom /run/current-system/sw/share/wallpapers/nix.png'';
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bigclock = true;
    };
  };

  services.printing.enable = true;

  services.printing.drivers = [ pkgs.cnijfilter2 ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = [ "*" ];
  };

  services.flatpak.enable = true;

  services.tailscale.enable = true;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  services.blueman.enable = true;

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
  };

  services.openssh.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
