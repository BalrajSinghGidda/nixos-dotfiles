{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/apple-sound.nix
  ];

  networking.hostName = "mac-btw";

  boot.kernelParams = ["mem_sleep_default=s2idle"];

  # Work around slow/unstable resume on some MBP14,1 NVMe controllers.
  systemd.services.disable-nvme-d3cold = {
    description = "Disable NVMe d3cold on MacBookPro14,1";
    before = ["suspend.target"];
    path = [pkgs.bash pkgs.coreutils];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${inputs.nixos-hardware}/apple/macbook-pro/14-1/disable-nvme-d3cold.sh";
      TimeoutSec = 0;
    };
    wantedBy = ["multi-user.target" "suspend.target"];
  };

  # FacetimeHD driver fails to build on latest kernels; disable to keep linuxPackages_latest.
  hardware.facetimehd.enable = false;

  system.stateVersion = "25.11"; # Did you see the session context date? 2026.
}
