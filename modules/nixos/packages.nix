{pkgs, ...}: let
  apple-fonts = pkgs.callPackage ./apple-fonts.nix {};
in {
  environment.systemPackages = with pkgs; [
    git
    matugen
    kitty
    wget
    nitch
    curl
    nitch
    github-copilot-cli
    yazi
    gemini-cli
    lazygit
    pcmanfm
    appimage-run
    unzip
    p7zip
    gh
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
    upower
    bluez
  ];

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
