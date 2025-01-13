{inputs, ...}: {
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ../../common/desktop/vr
    ../../common/desktop/niri
    ../../common/desktop
    ../../common/zram.nix
    ../../common/systemdboot
    ../../common
    ./configuration.nix
    ./home.nix
  ];
  home-manager.users.nyx.imports = [
    ../../common/home/desktop/ungoogled-chromium
    ../../common/home/desktop
    ../../common/home/gaming
    ../../common/home/gaming/vr
  ];
}
