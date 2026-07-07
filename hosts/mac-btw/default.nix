{
  inputs,
  pkgs,
  config,
  ...
}: let
  user = "balraj";
  uid = config.users.users.${user}.uid;
  lidAction = pkgs.writeShellScript "lid-action" ''
    set -euo pipefail

    run_niri_action() {
      local action="$1"
      local runtime="/run/user/${toString uid}"
      local socket=""

      if [ -d "$runtime" ]; then
        socket="$(ls -1 "$runtime"/niri*.sock 2>/dev/null | head -n1 || true)"
      fi

      if [ -z "$socket" ]; then
        socket="$(ls -1 /tmp/niri*.sock 2>/dev/null | head -n1 || true)"
      fi

      if [ -n "$socket" ]; then
        ${pkgs.util-linux}/bin/runuser -u ${user} -- env \
          XDG_RUNTIME_DIR="$runtime" \
          NIRI_SOCKET="$socket" \
          ${pkgs.niri}/bin/niri msg action "$action"
      fi
    }

    state="$(awk '{print $2}' /proc/acpi/button/lid/LID0/state 2>/dev/null || true)"
    if [ "$state" = "closed" ]; then
      ${pkgs.systemd}/bin/loginctl lock-session
      run_niri_action power-off-monitors
    elif [ "$state" = "open" ]; then
      run_niri_action power-on-monitors
    fi
  '';
in {
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

  services.logind.settings.Login = {
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
    HandleLidSwitch = "lock";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowSuspendThenHibernate = "no";
    AllowHybridSleep = "no";
  };

  services.acpid.enable = true;
  services.acpid.handlers.lid = {
    event = "button/lid.*";
    action = "${lidAction}";
  };

  # FacetimeHD driver fails to build on latest kernels; disable to keep linuxPackages_latest.
  hardware.facetimehd.enable = true;

  system.stateVersion = "25.11"; # Did you see the session context date? 2026.
}
