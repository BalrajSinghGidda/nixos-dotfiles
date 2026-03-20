{
  description = "NixOS on Dell Latitude 7490";

  # Flake inputs - dependencies for this configuration
  inputs = {
    # NixOS 25.11 stable channel
    nixpkgs.url = "nixpkgs/nixos-25.11";
    
    # Home Manager for user-level configuration management
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # Ensure Home Manager uses the same nixpkgs as system
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs - what this flake produces
  outputs = { self, nixpkgs, home-manager, ... }: {
    # System configuration for the "nixos-btw" host
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import host-specific configuration
        ./hosts/nixos-btw
        
        # Enable Home Manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            # Use system-level pkgs for Home Manager
            useGlobalPkgs = true;
            # Install packages to /etc/profiles instead of ~/.nix-profile
            useUserPackages = true;
            # Import Home Manager configuration for user 'balraj'
            users.balraj = import ./hosts/nixos-btw/home.nix;
            # Backup existing files with .backup extension on conflicts
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}