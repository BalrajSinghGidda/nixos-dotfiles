{pkgs, ...}: let
  apple-fonts = pkgs.callPackage ./apple-fonts.nix {};
in {
  environment.systemPackages = with pkgs; [
    git
    matugen
    kitty
    wget
    nitch
    kdePackages.dolphin
    curl
    power-profiles-daemon
    nitch
    github-copilot-cli
    cups-pk-helper
    yazi
    gemini-cli
    lazygit
    appimage-run
    unzip
    p7zip
    gh
    nh
    nix-output-monitor
    nvd
    xdg-desktop-portal-hyprland
    hyprland-qt-support
    hyprland-qtutils
    capitaine-cursors-themed
    libnotify
    dunst
    pamixer
    alsa-utils
    accountsservice
    cups-pk-helper
    vscodium
    blueman
    kdePackages.qt6ct
    upower
    bluez
  ];

  programs.kdeconnect = {
    enable = true;
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      corefonts
      vista-fonts
      apple-fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ];
  };
}
