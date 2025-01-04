{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./configuration.nix
    ../../common/desktop/niri
    ../../common/desktop/vr
    ../../common/services
    ../../common/steamdeck
    ../../common/desktop
    ../../common/desktop/gaming.nix
    ../../common/grub
    ../../common
    ../../common/zram.nix

    # home-manager
    ./home.nix
    ../../users/nyx.nix
  ];

  home-manager.users.nyx.imports = [
    ../../common/home/desktop
  ];
}
