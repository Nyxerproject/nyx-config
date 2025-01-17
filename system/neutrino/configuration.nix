{
  networking.hostName = "neutrino";

  services.xserver.enable = false;

  #boot.loader.grub.device = "dev/vda1";

  system.stateVersion = "25.05";
}
