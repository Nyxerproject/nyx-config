{config, ...}: {
  environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nextcloud = {
    settings = let
      prot = "http";
      host = "127.0.0.1";
      dir = "/nextcloud";
    in {
      enable = true;
      configureRedis = true;
      hostName = "localhost";
      config.adminpassFile = "/etc/nextcloud-admin-pass";
      overwriteprotocol = prot;
      overwritehost = host;
      overwritewebroot = dir;
      htaccess.RewriteBase = dir;
      overwrite.cli.url = "${prot}://${host}${dir}/";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
  };
}
