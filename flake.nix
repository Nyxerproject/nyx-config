{
  description = "My silly (bad) flake :3";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:Nyxerproject/nixpkgs/nixos-unstable";
    fuckthis.url = "github:ibizaman/nixpkgs/node-cert-exporter";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    agenix.url = "github:ryantm/agenix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    #stylix.url = "github:brckd/stylix/1e3c0f13803c8169070d65bcf39ed403e1df2111";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    sops-nix.url = "github:Mic92/sops-nix";
    kiara.url = "github:StardustXR/kiara";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
    selfhostblocks.url = "github:ibizaman/selfhostblocks";
  };
  outputs = {
    self,
    selfhostblocks,
    ...
  } @ inputs
  : let
    system = "x86_64-linux";
    # nixpkgs' = (import inputs.nixpkgs {system = "x86_64-linux";}).applyPatches {
    #   name = "nixpkgs-patched";
    #   src = inputs.nixpkgs;
    #   patches = [
    #     (builtins.fetchurl {
    #       url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/368325.patch";
    #       sha256 = "sha256:01vrnrr8kh2vdgxkcni99r9xv74jh5l0cc9v0j07invlfdl9jpin=";
    #     })
    #   ];
    # };
    # inputs.nixpkgs.overlays = [
    #   (final: prev: {
    #     nixpkgs = prev.nixpkgs.overrideAttrs (old: {
    #       patches =
    #         (old.patches or [])
    #         ++ [
    #           (builtins.fetchurl {
    #             url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/368325.patch";
    #             sha256 = "01vrnrr8kh2vdgxkcni99r9xv74jh5l0cc9v0j07invlfdl9jpin";
    #           })
    #         ];
    #     });
    #   })
    # ];
    # nixpkgs-patched = (import inputs.nixpkgs {inherit system;}).applyPatches {
    #   name = "nixpkgs-patched-368325";
    #   src = inputs.nixpkgs;
    #   patches = [
    #     (builtins.fetchurl {
    #       url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/368325.patch";
    #       sha256 = "01vrnrr8kh2vdgxkcni99r9xv74jh5l0cc9v0j07invlfdl9jpin";
    #     })
    #   ];
    # };
    #pkgs = import nixpkgs-patched {inherit system;};
    #
    # originPkgs = selfhostblocks.inputs.nixpkgs.legacyPackages.${system};
    # patches = originPkgs.lib.optionals [
    #   (originPkgs.fetchpatch {
    #     url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/368325.patch";
    #     hash = "sha256-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=";
    #   })
    # ];
    # patchedNixpkgs = originPkgs.applyPatches {
    #   name = "nixpkgs-patched";
    #   src = inputs.nixpkgs;
    #   inherit patches;
    # };
  in {
    nixosModules = {
      myGraphicalEnv.imports = [];
      server.imports = [selfhostblocks.nixosModules.${system}.default];
    }; # TODO: remove "specialArgs = {inherit inputs;};" from all nixosConfigs
    nixosConfigurations = {
      antidown = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/antidown];
        specialArgs = {inherit inputs;};
      };
      bottom = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/bottom];
        specialArgs = {inherit inputs;};
      };
      charm = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/charm];
        specialArgs = {inherit inputs;};
      };
      down = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/down];
        specialArgs = {inherit inputs;};
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
      #top = pkgs.lib.nixosSystem {
      top = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          selfhostblocks.nixosModules.${system}.default
          self.nixosModules.server
          ./system/top
        ];
        specialArgs = {inherit inputs;};
      };
    };
    # deploy.nodes = {
    #   particles = {
    #     sshOpts = ["-p" "2221"];
    #     hostname = "localhost";
    #     fastConnection = true;
    #     interactiveSudo = true;
    #     profiles = {
    #       charm-er = {
    #         sshUser = "nyx";
    #         path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.charm;
    #         user = "root";
    #       };
    #       down-er = {
    #         sshUser = "nyx";
    #         path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.down;
    #         user = "root";
    #       };
    #       top-er = {
    #         sshUser = "nyx";
    #         path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.top;
    #         user = "root";
    #       };
    #     };
    #   };
    #   down = {
    #     hostname = "down";
    #     fastConnection = true;
    #     interactiveSudo = true;
    #     profiles = {
    #       system = {
    #         sshUser = "nyx";
    #         path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.down;
    #         user = "root";
    #       };
    #     };
    #   };
    # };

    # checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
  };
}
