{inputs, ...}: {
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
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
  ];
}
