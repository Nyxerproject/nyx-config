{pkgs, ...}: {
  services.slskd = {
    enable = true;
    #domain = "localhost/slskd";
    #user = "nyx";
  };
}
