{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nextcloud
  ];

  environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nextcloud = {
    enable = true;
    hostName = "localhost";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
  };
}
