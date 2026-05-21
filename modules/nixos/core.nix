{pkgs, ...}: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Nix Settings
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Timezone and Locale
  time.timeZone = "Asia/Kolkata"; # Replace with your timezone if needed
  i18n.defaultLocale = "en_US.UTF-8";

  # User Configuration
  users.users.balraj = {
    isNormalUser = true;
    description = "balraj";
    extraGroups = ["networkmanager" "wheel" "video"];
    shell = pkgs.nushell; # Set Nushell as default system shell
  };

  environment.shells = with pkgs; [nushell];

  # Networking
  networking.networkmanager.enable = true;
}
