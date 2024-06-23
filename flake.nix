{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
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
    envision = {
      url = "gitlab:Scrumplex/envision/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pkgs-mndvlknlyrs.url = "github:Scrumplex/nixpkgs/nixos/monado/vulkan-layers"; # TODO: remove when merged
  };

  outputs = {
    self,
    nixpkgs,
    systems,
    home-manager,
    nixpkgs-xr,
    flake-utils,
    envision,
    pkgs-mndvlknlyrs,
    ...
  } @ inputs: let
    # overlay = final: prev: {
    # inherit (pkgs-mndvlknlyrs.legacyPackages.${prev.system})
    # monado-vulkan-layers;
    # };
    # inherit (self) outputs;
    # pkgs = import nixpkgs {
    # system = "x86_64-linux";
    # overlays = [ overlay ];
    # };
    pkgsmndvlknlyrs = import pkgs-mndvlknlyrs {
      config.allowUnfree = true;
      system = "x86_64-linux";
      # hostPlatform.config = "x86_64-unknown-linux-gnu";
      # config.cudaSupport = true;
      # config.cudaVersion = "12";
    };
  in {
    nixosConfigurations = {
      bottom = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bottom
          # ./hosts/common/desktop/gaming.nix
          # ./hosts/common/desktop
          # ./hosts/common/desktop/mullvad.nix
          nixpkgs-xr.nixosModules.nixpkgs-xr
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nyx =
                import
                ./home/nyx/bottom.nix;
            };
          }
        ];
        specialArgs = {
          inherit inputs pkgsmndvlknlyrs;
        };
      };
    };
  };
}
