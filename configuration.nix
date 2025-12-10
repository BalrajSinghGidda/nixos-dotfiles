{ config, lib, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
    displayManager.sessionCommands = ''
      xwallpaper --zoom /etc/walls/nix.png'';
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bigclock = true;
    };
  };
  nixpkgs.config.allowUnfree = true;

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

  users.users.balraj = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  boot.kernelModules = [
      "dell-wmi"
      "dell-wmi-sysman"
      "dell-smbios"
      "dell-wmi-descriptor"
      "video"
      "sparse-keymap"
  ];

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

  environment.systemPackages = with pkgs; [
    vim
      wget
      nitch
      git
      lazygit
      gh
      kitty
      neovim
      zellij
      tmux
      picom
      rofi
      redis
      xwallpaper
      oh-my-posh
      brightnessctl
      pamixer
      direnv
      libnotify
      dunst
      maim
      slop
      xbindkeys
      alsa-utils
      libinput
      blueman
      bluez
      xclip
      xcb-util-cursor
      libreoffice
      feh
      ];

  fonts.fontDir.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    corefonts
    vista-fonts
    nerd-fonts.lilex
    nerd-fonts.ubuntu
  ];

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  system.stateVersion = "25.05";

}

