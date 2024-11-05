{
  description = "My silly (bad) flake :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    add-gem5.url = "github:nyxerproject/nixpkgs/add-gem5";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kiara = {
      url = "github:StardustXR/kiara";
    };

    jeezyvim.url = "github:nyxerproject/JeezyVim";

    nixvim.url = "github:nix-community/nixvim";

    # nixpkgs-wayland = {
    #   url = "github:nix-community/nixpkgs-wayland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    sops-nix.url = "github:Mic92/sops-nix";

    stylix.url = "github:danth/stylix";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

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

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    nixosConfigurations = {
      bottom = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/bottom
          inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
          inputs.nixvim.nixosModules.nixvim
          inputs.niri.nixosModules.niri
          inputs.nixos-generators.nixosModules.all-formats
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.chaotic.nixosModules.default
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      down = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/down
          inputs.niri.nixosModules.niri
          inputs.disko.nixosModules.disko
          inputs.nixvim.nixosModules.nixvim
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      muon = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/muon
          inputs.niri.nixosModules.niri
          inputs.nixvim.nixosModules.nixvim
          inputs.disko.nixosModules.disko
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      top = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/top
          inputs.home-manager.nixosModules.home-manager
          inputs.disko.nixosModules.disko
          inputs.nixvim.nixosModules.nixvim
        ];
        specialArgs = {
          inherit inputs;
        };
      };
      strange = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/strange
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-wsl.nixosModules.default
          inputs.nixvim.nixosModules.nixvim
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
            wsl.defaultUser = "nyx";
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
