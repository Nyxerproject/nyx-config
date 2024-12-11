{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../common/desktop/niri
    ../common/services
    ../common/desktop
    ../common/zram.nix
    ../common/grub
    ../common
    ./configuration.nix
  ];
}
