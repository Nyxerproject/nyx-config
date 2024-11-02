{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../users/nyx.nix
    ../common/services
    ../common/zram.nix
    ../common/services/server_stuff.nix
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
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nyx = import ../../home/nyx/top;
  };

  environment.systemPackages = let
    gem5 = import inputs.add-gem5 {
      config.allowUnfree = true;
      system = "x86_64-linux"; # TODO: there is prob a better way of declaring this
    };
  in [gem5.gem5];

  environment = {
    sessionVariables = {
      FLAKE = "/home/nyx/nyx-config";
    };
  };

  system.stateVersion = "24.05";
}
