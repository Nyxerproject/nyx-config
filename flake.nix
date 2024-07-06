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
    system = "x86_64-linux";
    pkgsmndvlknlyrs = import pkgs-mndvlknlyrs {
      config.allowUnfree = true;
      inherit system;
    };
    # nixpkgs-xr-overlay = final: prev: {
    #   default.monado = prev.monado.overrideAttrs {
    #     src = prev.fetchFromGitLab {
    #       domain = "gitlab:freedesktop.org";
    #       owner = "monado";
    #       repo = "monado";
    #       rev = "557dfa8bf14f75faa185af278e621c1e468b6cde";
    #       hash = "sha256-LcKdj0fI1462UswyRojfb2awtbKUPPlJohIOJUSNYA0=";
    #     };
    #   };
    # };
    # pkgs = nixpkgs.legacyPackages.${system};
    # pkgs = import nixpkgs {
    #  inherit system;
    # overlays = [nixpkgs-xr-overlay];
    #};
  in {
    nixosConfigurations = {
      bottom = nixpkgs.lib.nixosSystem {
        inherit system;
        # inherit pkgs;
        modules = [
          ./hosts/bottom
          home-manager.nixosModules.home-manager
          nixpkgs-xr.nixosModules.nixpkgs-xr
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nyx = import ./home/nyx/bottom.nix;
            };
          }
        ];
        specialArgs = {
          inherit inputs pkgsmndvlknlyrs;
        };
      };
    };
    nixConfig = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
