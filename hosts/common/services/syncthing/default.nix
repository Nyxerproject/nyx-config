{
  services = {
    syncthing = {
      enable = true;
      #user = "nyx";
      dataDir = "/home/nyx/Documents";
      configDir = "/home/nyx/.config/syncthing";
      overrideDevices = true; # overrides any devices added or
    };
  };
}
