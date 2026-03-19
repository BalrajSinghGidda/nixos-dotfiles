{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  nixpkgs.config.allowUnfree = true;

  programs.bash.completion.enable = true;
  programs.bash.blesh.enable = true;

  programs.firefox.enable = true;

  boot.kernelModules = [
      "dell-wmi"
      "dell-wmi-sysman"
      "dell-smbios"
      "dell-wmi-descriptor"
      "video"
      "sparse-keymap"
  ];

  users.users.balraj = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networking" ];
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
