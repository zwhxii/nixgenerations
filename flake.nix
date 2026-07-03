{
  description = "nix snezhinki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # или nixos-24.11
    mangowm = {
      url = "github:mangowm/mango/0.14.4";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = inputs @ { self, nixpkgs, mangowm }: {
    nixosConfigurations.NixOSMachine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
