{
  imports = [
    ./configuration.nix
    ../../common/desktop/niri
    ../../common/services
    ../../common/desktop
    ../../common
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./home.nix
  ];

  home-manager.users.nyx.imports = [
    ../../common/home/desktop
  ];
}
