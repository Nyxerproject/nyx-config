{
  networking.hostName = "charm";

  hardware.opengl = {enable = true;};

  #  services.xserver.enable = true;

  services.displayManager.sddm.enable = false;

  home-manager.users.nyx = import ../../home/nyx/charm;

  system.stateVersion = "24.05";
}
