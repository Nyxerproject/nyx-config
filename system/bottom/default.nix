{inputs, ...}: {
  imports = [
    inputs.chaotic.nixosModules.default
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ../common/desktop/vr
    ../common/desktop/niri
    ../common/desktop
    ../common/desktop/gaming.nix
    ../common/zram.nix
    ../common/systemdboot
    ../common
    ./configuration.nix
    ./home.nix
  ];
  home-manager.users.nyx.imports = [
    ../common/home/desktop
    ../common/home/games/gaming.nix
    ../common/home/vr
  ];
}
