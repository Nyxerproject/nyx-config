{
  networking.hostName = "top";
  services.xserver.enable = false;
  services.logind.lidSwitchExternalPower = "ignore";
  services.displayManager.sddm.enable = false;
}
