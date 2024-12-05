{
  description = "My silly (bad) flake :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    agenix.url = "github:ryantm/agenix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    sops-nix.url = "github:Mic92/sops-nix";
    #kiara.url = "github:StardustXR/kiara";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      bottom = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/bottom];
        specialArgs = {inherit inputs;};
      };
      down = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/down];
        specialArgs = {inherit inputs;};
      };
      muon = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/muon];
        specialArgs = {inherit inputs;};
      };
      top = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/top];
        specialArgs = {inherit inputs;};
      };
      strange = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/strange];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
