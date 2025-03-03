{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./home.nix
    ../../users/nyx.nix

    ../../common
    ../../common/desktop
    ../../common/services
    ../../common/packages/R.nix
  ];

  home-manager.users.nyx.imports = [../../common/home/desktop];
}
