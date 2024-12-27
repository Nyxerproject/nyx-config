{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../common/desktop/niri
    ../common/services
    ../common/desktop
    ../common/desktop/gaming.nix
    ../common/zram.nix
    ../common/grub
    ../common
    ./configuration.nix
    ./home.nix
  ];
  home-manager.users.nyx.imports = [
    ../common/home/desktop
    ../common/home/desktop/ungoogled-chromium
  ];
}
