{
  networking.hostName = "muon";

  services.xserver.enable = true;

  home-manager.users.nyx = import ../../home/nyx/muon;

  system.stateVersion = "24.05";
}
