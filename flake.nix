{
  description = "My silly (bad) flake :3";

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
      url = "github:nix-community/nixpkgs-xr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    monadoVulkanLayer.url = "github:Scrumplex/nixpkgs/nixos/monado/vulkan-layers"; # TODO: remove when merged

    xwayland-satellite = {
      url = "github:gabthebab/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      # Optional, by default this flake follows nixpkgs-unstable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
  in {
    nixosConfigurations = {
      bottom = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/bottom
          inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
          inputs.niri-flake.nixosModules.niri
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      down = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/down
          inputs.niri-flake.nixosModules.niri
          inputs.disko.nixosModules.disko
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          # inherit monadoVulkanLayer;
          inherit inputs;
        };
      };
      muon = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/muon
          inputs.niri-flake.nixosModules.niri
          inputs.disko.nixosModules.disko
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
    nixConfig = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
