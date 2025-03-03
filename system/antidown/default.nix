{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./home.nix
    ../../users/nyx.nix

    ../../common
    ../../common/desktop
    ../../common/packages/R.nix
  ];
}
