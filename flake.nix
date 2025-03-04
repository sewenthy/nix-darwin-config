{
  description = "Sewen's Minimal Nix Darwin Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, home-manager, mac-app-util, nix-darwin
    , nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ]; # or "x86_64-darwin" for Intel Macs
      flake = {

        darwinConfigurations."minimal" =
          nix-darwin.lib.darwinSystem { # change to your hostname
            specialArgs = { inherit inputs; };
            system = "aarch64-darwin"; # or "x86_64-darwin" for Intel Macs
            modules = [
              mac-app-util.darwinModules.default
              home-manager.darwinModules.home-manager
              ./configuration.nix
            ];
          };
      };
    };
}
