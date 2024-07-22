{
  lib,
  pkgs,
  ...
}: {
  imports = [
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
    # display things
    xserver = {
      enable = true;
    };
    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "nyx"; # login things
    };
  };

  users.users.nyx = {
    # TODO move to seporate nix file (module?)
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$y$j9T$d2moNWhXMPaPXQQlBS9J7/$uQKwf.Y0xRKzbaOZCFybnrUeqB3HAnUiuzL17wA7/P3";
  };

  environment = {
    systemPackages = with pkgs; [
      rio
      fuzzel
    ];
    sessionVariables = {
      FLAKE = "/home/nyx/nyx-config";
    };
  };

  system.stateVersion = "24.05";
}
