{inputs, ...}: {
  imports = [
    inputs.chaotic.nixosModules.default
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ../common/desktop/vr
    ../common/desktop/niri
    ../common/desktop
    ../common/zram.nix
    ../common/systemdboot
    ../common
    ./configuration.nix
    ./home.nix
  ];
  home-manager.users.nyx.imports = [
    ../common/home/desktop
    ../common/home/desktop/ungoogled-chromium
    ../common/home/gaming
    ../common/home/gaming/vr
  ];
}
