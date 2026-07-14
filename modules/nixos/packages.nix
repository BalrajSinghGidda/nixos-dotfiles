{ pkgs, ... }:
let
  apple-fonts = pkgs.callPackage ./apple-fonts.nix { };
in
{
  environment.systemPackages = with pkgs; [
    # --- Core Utilities ---
    git
    wget
    curl
    unzip
    p7zip
    libnotify
    nitch

    # --- Nix & Development Tools ---
    nh
    nix-output-monitor
    nvd
    gemini-cli
    github-copilot-cli
    gh

    # --- Desktop Environment & Window Manager ---
    niri
    xdg-desktop-portal-wlr
    dunst
    pamixer
    alsa-utils

    # --- TUI / Terminal Utilities ---
    yazi
    lazygit
    appimage-run

    # --- GUI Applications ---
    vivaldi
    vscodium
    vlc
    libreoffice
    kdePackages.dolphin
    kitty

    # --- Themes & Appearance ---
    capitaine-cursors-themed
    tela-icon-theme
    whitesur-icon-theme
    kdePackages.qt6ct
    matugen

    # --- Hardware, Power & Services ---
    power-profiles-daemon
    cups-pk-helper
    upower
    bluez
    blueman
    accountsservice
    ntfs3g
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
