{
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./configuration.nix
    ./home.nix

    ../../common
    ../../common/desktop
    ../../common/desktop/gaming
    ../../common/desktop/gaming/vr
    ../../common/setups/zram
    ../../common/boot/systemdboot
  ];
}
