{
  description = "NixOS + Hyprland + DMS + Matugen + Nushell Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

    # DankMaterialShell: Comprehensive desktop shell and greeter
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    home-manager,
    dms,
    nix-alien,
    danksearch,
    ...
  } @ inputs: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nixos-btw/default.nix
        dms.nixosModules.greeter # Enable DMS login system

        nvf.nixosModules.default

        # Add nix-alien to system packages
        # Enables running unpatched binaries with automatic library detection
        ({pkgs, ...}: {
          environment.systemPackages = [
            nix-alien.packages.x86_64-linux.nix-alien
          ];
        })

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs;};
            users.balraj = import ./hosts/nixos-btw/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
    nixosConfigurations.mac-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/mac-btw/default.nix
        dms.nixosModules.greeter # Enable DMS login system

        nvf.nixosModules.default

        # Add nix-alien to system packages
        # Enables running unpatched binaries with automatic library detection
        ({pkgs, ...}: {
          environment.systemPackages = [
            nix-alien.packages.x86_64-linux.nix-alien
          ];
        })

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs;};
            users.balraj = import ./hosts/nixos-btw/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
