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
      url = "github:nix-community/nixpkgs-xr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    envision = {
      url = "gitlab:Scrumplex/envision/nix";
      # url = "gitlab:gabmus/envision?ref=pull/11/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-xr,
    envision,
    ...
  } @ inputs: {
    nixosConfigurations = {
      bottom = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bottom
          ./hosts/common/desktop/gaming.nix
          ./hosts/common/desktop/mullvad.nix
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
          ({pkgs, ...}: {
            # Adding the package to `nixpkgs.overlays`. This means that when we use `pkgs` the package will be added to
            # it. Overlay function takes two arguments: `final` and `prev`. We do not need these for this case as we are
            # not overriding something that exists we are adding something new, so I used `_` for those. I am creating a
            # new package called `tkiat-custom-st` and setting that equal to the flake's defaultPackage. I did this
            # because this flake only defines a defaultPackage (it should define an overlay, and a package)
            nixpkgs.overlays = [
              (_: _: {envision = inputs.envision;})
            ];

            # We can now add the package from our overlays
            environment.systemPackages = [pkgs.envision];
          })
        ];
      };
    };
  };
}
