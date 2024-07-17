{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-xr = {
      url = "github:nyxerproject/nixpkgs-xr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    monadoVulkanLayer.url = "github:Scrumplex/nixpkgs/nixos/monado/vulkan-layers"; # TODO: remove when merged

    niri = {
      url = "github:YaLTeR/niri/v0.1.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.niri-unstable.follows = "niri";
      inputs.niri-stable.follows = "niri";
    };

    kiara = {
      url = "github:StardustXR/kiara";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    stylix.url = "github:danth/stylix";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    monadoVulkanLayer = import inputs.monadoVulkanLayer {
      config.allowUnfree = true;
      inherit system;
    };
  in {
    nixosConfigurations = {
      bottom = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/bottom
          inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nyx = import ./home/nyx/bottom.nix;
            };
          }
        ];
        specialArgs = {
          inherit monadoVulkanLayer;
          inherit inputs;
        };
      };
      down = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/down
          inputs.niri-flake.nixosModules.niri
          ({pkgs, ...}: {programs.niri.enable = true;})
          inputs.disko.nixosModules.disko
        ];
      };
    };
    nixConfig = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
