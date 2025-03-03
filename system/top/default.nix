{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../users/nyx.nix

    ../../common
    ../../common/boot/grub
    ../../common/properties/zram
    ../../common/services/server_stuff.nix
  ];
}
