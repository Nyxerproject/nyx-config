{
  jovian = {
    devices.steamdeck = {
      enable = true;
      autoUpdate = true;
    };
    decky-loader = {
      extraPackages = [];
      enable = true;
    };
    hardware.has.amd.gpu = true;
    steam = {
      desktopSession = "plasma";
      user = "nyx";
      autoStart = true;
      enable = true;
    };
  };
  services.desktopManager.plasma6.enable = true;
}
