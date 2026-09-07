{
  description = "nix snezhinki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-old-lo.url = "github:NixOS/nixpkgs/044bfe75bfe4c7bbe043dc17b5e42ea823b84a09";
    mangowm = {
      url = "github:mangowm/mango/0.14.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, mangowm, home-manager, nixpkgs-old-lo }: {
    nixosConfigurations.NixOSMachine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.whixie = ./home.nix;
        }
        ({ pkgs, ... }: {
          environment.systemPackages = [
            nixpkgs-old-lo.legacyPackages.x86_64-linux.libreoffice-fresh
          ];
        })
      ];
    };
  };
}
