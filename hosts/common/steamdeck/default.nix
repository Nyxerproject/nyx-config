{inputs, ...}: {
  imports = [inputs.jovian.modules];
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
      defaultSession = "plasma";
      autoStart = true;
      steam.enable = true;
    };
  };
}
