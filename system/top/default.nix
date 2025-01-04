{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../users/nyx.nix
    ../../common/services
    ../../common/zram.nix
    ../../common/services/server_stuff.nix
    ../../common/grub
    ../../common
    ./configuration.nix
  ];

  home-manager.users.nyx.imports = [];
}
