{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../common/desktop/niri
    ../common/desktop
    ../common/grub
    ../common
    ./configuration.nix
  ];
}
