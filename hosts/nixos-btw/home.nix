{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager
  ];

  home.username = "balraj";
  home.homeDirectory = "/home/balraj";
  home.stateVersion = "25.05";

  # This is the idiomatic way to manage dotfiles in Home Manager.
  # It will copy the files to the Nix store and then link them to the correct location in ~/.config.
  xdg.configFile."nvim".source = ../../config/nvim;
  xdg.configFile."qtile".source = ../../config/qtile;
  xdg.configFile."rofi".source = ../../config/rofi;
  xdg.configFile."picom".source = ../../config/picom;
  xdg.configFile."kitty".source = ../../config/kitty;
}