{
  networking.hostName = "charm";
  hardware.graphics.enable = true;
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = false;
  };
}
