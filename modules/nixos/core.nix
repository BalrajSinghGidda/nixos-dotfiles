{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = true;
      theme = "hexagon_hud";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["hexagon_hud"];
        })
      ];
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;
  };

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
