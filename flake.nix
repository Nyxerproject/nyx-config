{
  description = "My silly (bad) flake :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

    hyprland.url = "github:hyprwm/Hyprland";

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
    nixosConfigurations = {
      bottom = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/bottom];
        specialArgs = {inherit inputs;};
      };
      antidown = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/antidown];
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
      top = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/top];
        specialArgs = {inherit inputs;};
      };
      strange = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/strange];
        specialArgs = {inherit inputs;};
      };
      charm = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./system/charm];
        specialArgs = {inherit inputs;};
      };
    };
    packages.x86_64-linux = {
      charm4deck = inputs.nixos-generators.nixosGenerate {
        inherit system;
        modules = [./system/charm];
        specialArgs = {inherit inputs;};
        format = "kexec-bundle";
      };
    };
    deploy.nodes.example = {
      sshOpts = ["-p" "2221"];
      hostname = "localhost";
      fastConnection = true;
      interactiveSudo = true;
      profiles = {
        charm-er = {
          sshUser = "nyx";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.charm;
          user = "root";
        };
        down-er = {
          sshUser = "nyx";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.down;
          user = "root";
        };
        top-er = {
          sshUser = "nyx";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.top;
          user = "root";
        };
      };
    };
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
  };
}
