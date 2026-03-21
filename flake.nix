{
  description = "NixOS on Dell Latitude 7490";

  # Flake inputs - dependencies for this configuration
  inputs = {
    # NixOS unstable channel (bleeding edge)
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home Manager for user-level configuration management
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # Ensure Home Manager uses the same nixpkgs as system
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs - what this flake produces
  outputs = { self, nixpkgs, home-manager, nix-alien, nvf, ... }: {
    # System configuration for the "nixos-btw" host
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit nix-alien; };
      modules = [
        # Import host-specific configuration
        ./hosts/nixos-btw
	
	nvf.nixosModules.default
	
        # Add nix-alien to system packages
        ({ pkgs, ... }: {
          environment.systemPackages = [
            nix-alien.packages.x86_64-linux.nix-alien
          ];
        })

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
