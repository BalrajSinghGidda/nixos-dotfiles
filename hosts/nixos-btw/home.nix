{ config, pkgs, ... }:

{
  # Import Home Manager modules (apps, git, shell, etc.)
  imports = [
    ../../modules/home-manager
  ];

  # User identity - CHANGE THESE for your system!
  home.username = "balraj";
  home.homeDirectory = "/home/balraj";

  # Home Manager state version - DON'T change this after initial setup
  home.stateVersion = "25.05";

  # Manage application dotfiles using XDG Base Directory specification
  # These files are copied to the Nix store and symlinked to ~/.config/
  xdg.configFile."qtile".source = ../../config/qtile;
  xdg.configFile."rofi".source = ../../config/rofi;
  xdg.configFile."picom".source = ../../config/picom;
  xdg.configFile."kitty".source = ../../config/kitty;
}
