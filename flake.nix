{
  description = "nix snezhinki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # или nixos-24.11
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.55.2";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = inputs @ { self, nixpkgs, hyprland }: {
    nixosConfigurations.NixOSMachine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
