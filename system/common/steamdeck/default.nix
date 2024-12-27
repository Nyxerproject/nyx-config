{inputs, ...}: {
  imports = [
    inputs.jovian.nixosModules.jovian
  ];
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
      desktopSession = "niri";
      user = "nyx";
      autoStart = true;
      enable = true;
    };
  };
}
