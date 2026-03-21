{ pkgs, ... }:

{
  # GUI applications (managed by Home Manager)
  home.packages = with pkgs; [
    # Package management
    flatpak # Universal package manager
    pcmanfm
    google-chrome
  ];
}
