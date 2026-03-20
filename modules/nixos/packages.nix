{ pkgs, ... }:

let
  wallpapers = (pkgs.callPackage ./wallpapers.nix {});
in
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    nitch
    git
    lazygit
    gh
    kitty
    unzip
    neovim
    zellij
    tmux
    picom
    rofi
    redis
    xwallpaper
    oh-my-posh
    brightnessctl
    pamixer
    udisks2
    eject
    direnv
    libnotify
    dunst
    maim
    slop
    xbindkeys
    alsa-utils
    libinput
    blueman
    bluez
    xclip
    xcb-util-cursor
    libreoffice
    feh
    wallpapers
  ];

  fonts.fontDir.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    corefonts
    vista-fonts
    nerd-fonts.lilex
    nerd-fonts.ubuntu
  ];
}
