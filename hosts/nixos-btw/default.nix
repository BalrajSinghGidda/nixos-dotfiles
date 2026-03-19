{ pkgs, ... }:

let
  wallpapers = pkgs.callPackage ../../pkgs/wallpapers.nix {};
in
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  environment.systemPackages = [ wallpapers ];
}