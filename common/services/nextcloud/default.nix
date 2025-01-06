{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  shb = {
    nextcloud = {
      enable = true;
      subdomain = "nextcloud";
      domain = "nyxer.xyz";
      defaultPhoneRegion = "US";
      adminPass.result = config.shb.sops.secret."nextcloud/adminpass".result;
      ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";
      version = 29;

      apps = {
        # ldap = {
        #   enable = true;
        #   host = "127.0.0.1";
        #   port = config.shb.ldap.ldapPort;
        #   dcdomain = config.shb.ldap.dcdomain;
        #   adminName = "admin";
        #   adminPassword.result = config.shb.sops.secret."nextcloud/ldap/admin_password".result;
        #   userGroup = "nextcloud_user";
        # };

        # sso = {
        #   enable = true;
        #   endpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
        #   clientID = "nextcloud";
        #   fallbackDefaultAuth = true; # TODO: turn off
        #   secret.result = config.shb.sops.secret."nextcloud/sso/secret".result;
        #   secretForAuthelia.result = config.shb.sops.secret."nextcloud/sso/secretForAuthelia".result;
        # };
      };
    };
  };
  /*
     services = {
    nginx.virtualHosts = {
      "cloud.nyx" = {
        forceSSL = true;
        enableACME = true;
      };

      "onlyoffice.nyx" = {
        forceSSL = true;
        enableACME = true;
      };
    };

    nextcloud = {
      # settings = let
      #   prot = "http";
      #   host = "127.0.0.1";
      #   #dir = "/nextcloud";
      # in {
      #   enable = true;
      #   configureRedis = true;
      #   hostName = "localhost";
      #   config.adminpassFile = config.sops.secrets.nextcloud.path;
      #   overwriteprotocol = prot;
      #   overwritehost = host;
      #   overwritewebroot = dir;
      #   htaccess.RewriteBase = dir;
      #   overwrite.cli.url = "${prot}://${host}${dir}/";
      # };
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
      };
      enable = true;
      hostName = "cloud.nyx";

      # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud27;

      # Let NixOS install and configure the database automatically.
      database.createLocally = true;

      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;

      # Increase the maximum file upload size to avoid problems uploading videos.
      maxUploadSize = "16G";
      https = true;
      enableBrokenCiphersForSSE = false;

      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        # List of apps we want to install and are already packaged in
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
        #inherit calendar contacts mail notes onlyoffice tasks;

        # Custom app installation example.
        cookbook = pkgs.fetchNextcloudApp rec {
          url = "https://github.com/nextcloud/cookbook/releases/download/v0.10.2/Cookbook-0.10.2.tar.gz";
          sha256 = "sha256-XgBwUr26qW6wvqhrnhhhhcN4wkI+eXDHnNSm1HDbP6M=";
        };
      };

      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "PT";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/path/to/nextcloud-admin-pass";
      };
    };

    onlyoffice = {
      enable = true;
      hostname = "onlyoffice.example.com";
    };
  };
  */

  # shb.sops.secret."nextcloud/ldap/adminPassword" = {
  #   request = config.shb.nextcloud.apps.ldap.adminPassword.request;
  #   settings.key = "ldap/userPassword";
  # };
  # shb.sops.secret."nextcloud/sso/secret".request = config.shb.nextcloud.apps.sso.secret.request;
  # shb.sops.secret."nextcloud/sso/secretForAuthelia" = {
  #   request = config.shb.nextcloud.apps.sso.secretForAuthelia.request;
  #   settings.key = "nextcloud/sso/secret";
  # };

  # Requester Module
  shb.sops.secret."nextcloud/adminpass".request = config.shb.nextcloud.adminPass.request;
  ##### secret =! secrets
  #shb.sops.secrets."nextcloud/adminpass".request = config.shb.nextcloud.adminPass.request;
  #shb.nextcloud.adminPass.result = config.sops.secrets."nextcloud/adminpass".result;

  # Manual Module
  # sops.secrets."nextcloud/adminpass".request = {
  #   #mode = "0400";
  #   owner = "nextcloud";
  #   group = "nextcloud";
  # };
  # shb.nextcloud.adminPass.path = config.sops.secrets."nextcloud/adminpass".path;
}
