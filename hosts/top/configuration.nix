{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../users/nyx.nix
    ../common
  ];

  # networking
  networking = {
    hostName = "top";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # filesystems, disks, and bootloading
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # services and background things
  services = {
    xserver = {
      enable = false;
    };
    nextcloud = {
      enable = true;
    };
    jellyfin = {
      enable = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nyx = import ../../home/nyx/top;
  };

  environment = {
    sessionVariables = {
      FLAKE = "/home/nyx/nyx-config";
    };
  };

  system.stateVersion = "24.05";
}
