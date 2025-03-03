{
  imports = [
    # ./configuration.nix
    {
      networking.hostName = "neutrino";
      services.xserver.enable = false;
    }
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../users/nyx.nix

    ../../common
    ../../common/boot/grub
  ];
}
