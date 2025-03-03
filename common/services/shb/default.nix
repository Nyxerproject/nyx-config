{
  outputs = {
    self,
    skarabox,
    selfhostblocks,
    sops-nix,
    deploy-rs,
  }: let
    system = "x86_64-linux";
    originPkgs = selfhostblocks.inputs.nixpkgs;

    shbNixpkgs = originPkgs.legacyPackages.${system}.applyPatches {
      name = "nixpkgs-patched";
      src = originPkgs;
      patches = selfhostblocks.patches.${system};
    };

    shbPkgs = import shbNixpkgs {inherit system;};

    # Taken from https://github.com/serokell/deploy-rs?tab=readme-ov-file#overall-usage
    deployPkgs = import originPkgs {
      inherit system;
      overlays = [
        deploy-rs.overlay
        (self: super: {
          deploy-rs = {
            inherit (shbPkgs) deploy-rs;
            lib = super.deploy-rs.lib;
          };
        })
      ];
    };

    domain = "nyxer.xyz";
  in {
    nixosModules.skarabox = {
      imports = [
        skarabox.nixosModules.skarabox
        selfhostblocks.nixosModules.${system}.default
        sops-nix.nixosModules.default
        ({config, ...}: {
          skarabox.hostname = "skarabox";
          skarabox.username = "skarabox";
          skarabox.disks.rootDisk = "/dev/nvme0n1";
          # 10% of size SSD. Default value assumes drive size is 1 Tb.
          skarabox.disks.rootReservation = "100G";
          skarabox.disks.dataDisk1 = "/dev/sda";
          skarabox.disks.dataDisk2 = "/dev/sdb";
          # 5% of size Hard Drives. Default value assumes drive size is 10 Tb.
          skarabox.disks.dataReservation = "500G";
          skarabox.sshAuthorizedKeyFile = ./ssh_skarabox.pub;
          skarabox.hostId = builtins.readFile ./hostid;
          # Needed to be able to ssh to decrypt the SSD.
          boot.initrd.availableKernelModules = ["rtw88_8821ce" "r8169"];
          sops.defaultSopsFile = ./secrets.yaml;
          sops.age = {sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];};
        })

        {me.domain = domain;}

        ./skarabox-configuration.nix
      ];
    };

    # Used with nixos-anywere for installation.
    nixosConfigurations.skarabox = shbNixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        self.nixosModules.skarabox
        {
          nix.settings.trusted-public-keys = [
            "selfhostblocks.cachix.org-1:H5h6Uj188DObUJDbEbSAwc377uvcjSFOfpxyCFP7cVs="
          ];

          nix.settings.substituters = [
            "https://selfhostblocks.cachix.org"
          ];
        }
      ];
    };

    # Used with deploy-rs for updates.
    deploy.nodes.skarabox = {
      hostname = domain;
      sshUser = "skarabox";
      sshOpts = ["-o" "IdentitiesOnly=yes" "-i" "ssh_skarabox"];
      activationTimeout = 600;
      profiles = {
        system = {
          user = "root";
          path = deployPkgs.deploy-rs.lib.activate.nixos self.nixosConfigurations.skarabox;
        };
      };
    };
    # From https://github.com/serokell/deploy-rs?tab=readme-ov-file#overall-usage
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
