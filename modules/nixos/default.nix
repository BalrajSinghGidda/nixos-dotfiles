# NixOS module aggregator
# This file imports all system-level configuration modules
{
  imports = [
    ./core.nix # Core system settings (boot, networking, users)
    ./packages.nix # System packages and fonts
    ./services.nix # System services and daemons
    ./nvf.nix # Neovim
  ];
}
