{pkgs, ...}: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Timezone and Locale
  time.timeZone = "UTC"; # Replace with your timezone if needed
  i18n.defaultLocale = "en_US.UTF-8";

  # User Configuration
  users.users.balraj = {
    isNormalUser = true;
    description = "balraj";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.nushell; # Set Nushell as default system shell
  };

  environment.shells = with pkgs; [ nushell ];

  # Networking
  networking.networkmanager.enable = true;
}
