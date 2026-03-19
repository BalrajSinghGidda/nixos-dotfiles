{ pkgs, ... }:

let
  custom-scripts = pkgs.callPackage ../../pkgs/custom-scripts.nix {};
in
{
  programs.gemini-cli = {
    enable = true;
    settings = {
      "theme" = "Default";
      "preferredEditor" = "nvim";
      "autoAccept" = true;
    };
    defaultModel = "gemini-2.5-pro";
  };

  home.packages = with pkgs; [
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    yazi
    flatpak
    eza
    zoxide
    python313Packages.euporie
    custom-scripts
  ];
}