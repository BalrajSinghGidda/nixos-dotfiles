{ config, lib, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "servos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  nixpkgs.config.allowUnfree = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.bash.completion.enable = true;
  programs.bash.blesh.enable = true;

  services.tailscale.enable = true;

  users.users.balraj = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  boot.kernelParams = [
    "consoleblank=10"
    "i915.enable_dc=0"      # Disables Display Power Saving to prevent hangs
    "i915.enable_psr=0"     # Disables Panel Self Refresh
    "intel_idle.max_cstate=1" # Limits CPU sleep states (prevents deep sleep freezes)
  ];

  services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "ignore";
  };

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

  virtualisation.oci-containers.containers.homepage = {
    image = "ghcr.io/gethomepage/homepage:latest";
    ports = [ "3000:3000" ];
    volumes = [
    	"/srv/homepage-config:/app/config"
	"/var/run/docker.sock:/var/run/docker.sock"
    ];

    environment = {
  HOMEPAGE_ALLOWED_HOSTS = "*";
};
  };

  environment.systemPackages = with pkgs; [
      vim
      wget
      nitch
      git
      lazygit
      gh
      neovim
      zellij
      tmux
      oh-my-posh
      direnv
      udisks2
      alsa-utils
      libinput
      blueman
      bluez
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  system.stateVersion = "25.05";

}

