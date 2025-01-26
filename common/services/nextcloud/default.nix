{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nextcloud = {
    enable = true;
    hostName = "top";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "pgsql";
    };
  };
}
/*
  services = {
    nginx.virtualHosts = {
      "cloud.nyxer.xyz" = {
        forceSSL = true;
        enableACME = true;
      };

      "onlyoffice.nyxer.xyz" = {
        forceSSL = true;
        enableACME = true;
      };
    };

    nextcloud = {
      enable = true;
      hostName = "nextcloud.nyxer.xyz";

      # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud30;

      # Let NixOS install and configure the database automatically.
      database.createLocally = true;

      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;

      # Increase the maximum file upload size to avoid problems uploading videos.
      maxUploadSize = "16G";
      #https = true;

      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        # List of apps we want to install and are already packaged in
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
        inherit calendar contacts mail notes onlyoffice tasks;

        # Custom app installation example.
        # cookbook = pkgs.fetchNextcloudApp rec {
        #   url = "https://github.com/nextcloud/cookbook/releases/download/v0.10.2/Cookbook-0.10.2.tar.gz";
        #   sha256 = "sha256-XgBwUr26qW6wvqhrnhhhhcN4wkI+eXDHnNSm1HDbP6M=";
        # };
      };

      config = {
        #overwriteProtocol = "https";
        defaultPhoneRegion = "US";
        dbtype = "pgsql";
        #adminuser = "nyx";
        #adminpassFile = config.sops.secrets."nextcloud/adminpass".path;
        adminpassFile = "/home/nyx/password.txt";
      };
    };

    onlyoffice = {
      enable = true;
      hostname = "onlyoffice.nyxer.xyz";
    };
  };
}
/*
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
      #ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";
      #ssl = config.shb.certs.selfsigned."nyxer.xyz";
      version = 29;
      dataDir = "/var/lib/nextcloud";
      tracing = null;

      apps = {
        #previewgenerator.enable = true;
        # ldap = {
        #   enable = true;
        #   host = "127.0.0.1";
        #   port = config.shb.ldap.ldapPort;
        #   dcdomain = config.shb.ldap.dcdomain;
        #   adminName = "admin";
        #   adminPassword.result = config.shb.sops.secret."nextcloud/ldap/admin_password".result;
        #   # userGroup = "nextcloud";
        # };
      };
    };
    sops.secret = {
      "nextcloud/adminpass".request = config.shb.nextcloud.adminPass.request;
      # "nextcloud/ldap/admin_password" = {
      #   request = config.shb.nextcloud.apps.ldap.adminPassword.request;
      #   settings.key = "ldap/userPassword";
      # };
    };
  };

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
  # sops.secrets."nextcloud/adminpass".request = {
  #   #mode = "0400";
  #   owner = "nextcloud";
  #   group = "nextcloud";
  # };
  ##### secret =! secrets ---like-here---> shb.sops.secrets."nextcloud/adminpass".request = config.shb.nextcloud.adminPass.request;

  # Manual Module
  # sops.secrets."nextcloud/adminpass".request = {
  #   #mode = "0400";
  #   owner = "nextcloud";
  #   group = "nextcloud";
  # };
  # shb.nextcloud.adminPass.path = config.sops.secrets."nextcloud/adminpass".path;
}
*/

