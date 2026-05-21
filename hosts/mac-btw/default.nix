{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "mac-btw";

  boot.kernelParams = ["mem_sleep_default=s2idle"];

  system.stateVersion = "25.11"; # Did you see the session context date? 2026.
}
