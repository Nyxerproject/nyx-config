{
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../common/desktop/niri
    ../common/desktop
    ../common
  ];

  # networking
  networking = {
    hostName = "down";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # filesystems, disks, and bootloading
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    # TODO fix and remove this. disko should automatically set this
    device = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBPNTY-512G-1006_20204F801215_1";
  };

  # services and background things
  services = {
    xserver = {
      enable = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nyx = import ../../home/nyx/down;
  };

  environment = {
    sessionVariables = {
      FLAKE = "/home/nyx/nyx-config";
    };
  };

  system.stateVersion = "24.05";
}
