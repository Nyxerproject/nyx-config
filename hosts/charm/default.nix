{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./disko-config.nix
    ./configuration.nix
    #../common/desktop/niri
    ../common/services
    ../common/steamdeck
    ../common/desktop
    ../common/grub
    ../common

    ../../users/nyx.nix
  ];
}
