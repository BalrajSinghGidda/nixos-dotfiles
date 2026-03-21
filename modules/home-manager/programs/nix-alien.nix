{ pkgs, ... }:

{
  # Nix-alien is a tool for running unpatched binaries on NixOS
  # It's installed at the system level via the flake.nix input
  # This module is kept for documentation and future configurations
  
  # Note: 
  # - nix-alien is added via flake.nix using the nix-alien flake input
  # - programs.nix-ld.enable is set at the system level in modules/nixos/core.nix
  # - To use: nix-alien <binary-name> or nix-alien-ld <binary>
  
  # Shell aliases for convenience
  programs.bash.shellAliases = {
    # Make nix-alien easier to use
    "na" = "nix-alien";
    "nald" = "nix-alien-ld";
  };
}
