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
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    declarative-nextcloud.url = "github:onny/nixos-nextcloud-testumgebung";
    selfhostblocks.url = "github:ibizaman/selfhostblocks";
    nc4nix = {
      url = "github:helsinki-systems/nc4nix";
      flake = false;
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
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
    vault-tasks = {
      url = "github:louis-thevenet/vault-tasks";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    nixosModules = {
      default.imports = [
        {
          nixpkgs.overlays = [
            inputs.sddm-sugar-candy-nix.overlays.default
            inputs.niri.overlays.niri
          ];
        }
        inputs.nixos-generators.nixosModules.all-formats
        inputs.nixvim.nixosModules.nixvim
        inputs.home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
        inputs.sops-nix.nixosModules.default
        inputs.stylix.nixosModules.stylix
        inputs.sddm-sugar-candy-nix.nixosModules.default
        inputs.nur.modules.nixos.default
      ];
      chaoic.imports = [inputs.chaotic.nixosModules.default];
      disko.imports = [inputs.disko.nixosModules.disko];
      gui.imports = [{home-manager.users.nyx.imports = [inputs.niri.homeModules.niri];}];
      xr.imports = [inputs.nixpkgs-xr.nixosModules.nixpkgs-xr];
      server.imports = [inputs.selfhostblocks.nixosModules.${system}.default];
      steamdeck.imports = [inputs.jovian.nixosModules.jovian];
      wsl.imports = [inputs.nixos-wsl.nixosModules.default];
    };
    # TODO: remove "specialArgs = {inherit inputs;};" from all nixosConfigs
    nixosConfigurations = {
      antidown = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/antidown
          self.nixosModules.default
          self.nixosModules.gui
          self.nixosModules.disko
        ];
        specialArgs = {inherit inputs;};
      };
      bottom = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/bottom
          self.nixosModules.default
          self.nixosModules.gui
          self.nixosModules.disko
          self.nixosModules.xr
        ];
        specialArgs = {inherit inputs;};
      };
      charm = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/charm];
        specialArgs = {inherit inputs;};
      };
      down = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/down
          self.nixosModules.default
          self.nixosModules.gui
          self.nixosModules.disko
          self.nixosModules.xr
        ];
      };
      muon = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/muon];
        specialArgs = {inherit inputs;};
      };
      strange = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/strange];
        specialArgs = {inherit inputs;};
      };
      top = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/top];
        specialArgs = {inherit inputs;};
      };
      neutrino = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/neutrino];
        specialArgs = {inherit inputs;};
      };
    };
    deploy.nodes = {
      down-deploy = {
        hostname = "down";
        fastConnection = true;
        interactiveSudo = true;
        profiles = {
          system = {
            sshUser = "nyx";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.down;
            user = "root";
          };
        };
      };
      antidown-deploy = {
        hostname = "antidown";
        fastConnection = true;
        interactiveSudo = true;
        profiles = {
          system = {
            sshUser = "nyx";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.antidown;
            user = "root";
          };
        };
      };
      # charm-deploy = {
      #   hostname = "charm";
      #   fastConnection = true;
      #   interactiveSudo = true;
      #   profiles = {
      #     system = {
      #       sshUser = "nyx";
      #       path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.charm;
      #       user = "root";
      #     };
      #   };
      # };
      top-deploy = {
        hostname = "top";
        fastConnection = true;
        interactiveSudo = true;
        profiles = {
          system = {
            sshUser = "nyx";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.top;
            user = "root";
          };
        };
      };
      # neutrino-deploy = {
      #   hostname = "top";
      #   fastConnection = true;
      #   interactiveSudo = true;
      #   profiles = {
      #     system = {
      #       sshUser = "nyx";
      #       path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.neutrino;
      #       user = "root";
      #     };
      #   };
      # };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
  };
}
