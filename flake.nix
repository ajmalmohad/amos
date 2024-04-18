{
  description = "Flake for ajmalmohad";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      amos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        inherit system;
        modules = [./nixos/configuration.nix];
      };
    };

    homeConfigurations."ajmalmohad" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
    };
  };
}
