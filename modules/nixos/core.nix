{ pkgs, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
  networking.hostName = "nixos-btw";  # Change this for your machine
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Asia/Kolkata";

  # Allow unfree packages (needed for some proprietary software)
  nixpkgs.config.allowUnfree = true;

  # Bash configuration
  programs.bash.completion.enable = true;
  programs.bash.blesh.enable = true;  # Bash Line Editor SHell

  # Firefox browser
  programs.firefox.enable = true;

  # Dell-specific kernel modules for proper hardware support
  boot.kernelModules = [
      "dell-wmi"              # WMI driver for Dell laptops
      "dell-wmi-sysman"       # System management
      "dell-smbios"           # SMBIOS interface
      "dell-wmi-descriptor"   # WMI descriptor
      "video"                 # Video driver
      "sparse-keymap"         # Sparse keymap support
  ];

  # User account configuration - CHANGE 'balraj' to your username!
  users.users.balraj = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networking" ];  # wheel = sudo access
    packages = with pkgs; [
      tree  # Directory tree visualization
    ];
  };

  # Enable Nix flakes and new nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NixOS state version - DON'T change after initial installation
  system.stateVersion = "25.11";
}
