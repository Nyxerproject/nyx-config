{
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ./configuration.nix

    ../../common
    ../../common/boot/grub
    ../../common/desktop
    ../../common/desktop/gaming
    ../../common/properties/steamdeck
    ../../common/properties/zram
  ];
}
