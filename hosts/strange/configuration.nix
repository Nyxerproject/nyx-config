{
  networking.hostName = "strange";

  services.xserver.enable = false;

  home-manager.users.nyx = import ../../home/nyx/strange;

  system.stateVersion = "24.05";
}
