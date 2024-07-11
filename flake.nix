{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-xr = {
      url = "github:nyxerproject/nixpkgs-xr";
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
    pkgsmndvlknlyrs.url = "github:Scrumplex/nixpkgs/nixos/monado/vulkan-layers"; # TODO: remove when merged
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgsmndvlknlyrs = import inputs.pkgsmndvlknlyrs {
      config.allowUnfree = true;
      inherit system;
    };
  in {
    # nixpkgs-xr = final: prev: {
    # };
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
    # pkgs = nixpkgs.legacyPackages.${system};
    # pkgs = import nixpkgs {
    #  inherit system;
    #  overlays = [nixpkgs-xr-overlay];
    #};
    # in {
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
          inherit pkgsmndvlknlyrs;
          inherit inputs;
        };
      };
    };
    nixConfig = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
