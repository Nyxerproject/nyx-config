{inputs, ...}: {
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../common/desktop/niri
    ../../common/desktop
    ../../common/grub
    ../../common
    ./configuration.nix
    ./home.nix
  ];
  home-manager.users.nyx.imports = [
    ../../common/home/desktop
  ];
}
