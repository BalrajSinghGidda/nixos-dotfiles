{
  description = "NixOS Server on Dell Latitude 7490";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    forgejo-cli.url = "git+https://codeberg.org/forgejo-contrib/forgejo-cli";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    forgejo-cli,
    ...
  }: {
    nixosConfigurations.servos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.balraj = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
