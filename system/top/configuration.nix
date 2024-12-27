{
  networking.hostName = "top";

  services.xserver.enable = false;

  home-manager.users.nyx = import ../../home/nyx/top;

  system.stateVersion = "24.05";
}
