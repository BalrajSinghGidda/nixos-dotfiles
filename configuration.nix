{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.getty.autologinUser = "balraj";

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  users.users.balraj = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    foot
    waybar
    kitty
    wofi
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

}

