{
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ./configuration.nix
    ./home.nix

    ../../common
    ../../common/desktop
    ../../common/desktop/gaming
    ../../common/desktop/gaming/vr
    ../../common/boot/grub
  ];
}
