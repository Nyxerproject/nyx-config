{
  services = {
    syncthing = {
      enable = true;
      user = "nyx";
      group = "users";
      dataDir = "/home/nyx/Documents";
      configDir = "/home/nyx/.config/syncthing";
      overrideDevices = true; # overrides any devices added or
      # settings.folders."Sync".path = "/home/nyx/Sync";
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
