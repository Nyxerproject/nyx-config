{
  services = {
    syncthing = {
      enable = true;
      user = "nyx";
      group = "users";
      dataDir = "/home/nyx/Documents";
      configDir = "/home/nyx/.config/syncthing";
      overrideDevices = true; # overrides any devices added or
      #devices = {};
      settings.folders."Sync" = {
        path = "/home/nyx/Sync";
        # devices = [];
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
