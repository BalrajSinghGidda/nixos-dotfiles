{ pkgs, ... }:

{
  # Nix-alien is a tool for running unpatched binaries on NixOS
  # Instead of using fetchTarball which requires SHA, we'll use the package from nixpkgs if available
  # or install it via the nix-ld mechanism

  # For now, commenting this out as it causes build errors
  # Users can install nix-alien manually if needed: nix-env -iA nixpkgs.nix-alien

  # home.packages = [
  #   pkgs.nix-alien or null
  # ];

  # Note: programs.nix-ld.enable is set at the system level in modules/nixos/core.nix
}
