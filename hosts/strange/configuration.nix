{
  imports = [
    ../../users/nyx.nix
    ../common
  ];

  # networking
  networking = {
    hostName = "strange";
    # networkmanager.enable = true;
    # firewall.enable = true;
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
    users.nyx = import ../../home/nyx/strange;
  };

  environment = {
    sessionVariables = {
      FLAKE = "/home/nyx/nyx-config";
    };
  };

  system.stateVersion = "24.05";
}
