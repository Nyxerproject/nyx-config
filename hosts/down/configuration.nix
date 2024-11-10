{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../common/desktop/niri
    ../common/desktop/gaming.nix
    ../common/services
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
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nyx = import ../../home/nyx/down;
  };

  environment.systemPackages = let
    gem5 = import inputs.add-gem5 {
      config.allowUnfree = true;
      system = "x86_64-linux"; # TODO: there is prob a better way of declaring this
    };
  in [
    pkgs.libreoffice-qt6-fresh
    gem5.gem5
  ];

  environment = {
    sessionVariables = {
      FLAKE = "/home/nyx/nyx-config";
    };
  };

  system.stateVersion = "24.05";
}
