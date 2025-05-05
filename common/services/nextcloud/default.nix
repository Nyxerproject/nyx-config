{
  self,
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  domain = "nyxer.xyz";
  host = "nextcloud.${domain}";
in {
  imports = [./nextcloud-extras.nix];

  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = host;
      webserver = "nginx";
      https = true;
      database.createLocally = true;
      config = {
        dbtype = "mysql";
        adminpassFile = "/var/run/secrets/nextcloud-admin-password";
      };
      configureRedis = true;
      settings = {
        trusted_domains = [
          "${host}"
          "www.${host}"
        ];
        overwriteprotocol = "https";
        # PHP options
        loglevel = 3;
        log_type = "file";
        logfile = "nextcloud.log";
        default_phone_region = "US";
        default_language = "en";
        default_locale = "en_US";
        maintenance_window_start = 2;
        # filelocking.enabled = true;
        enabledPreviewProviders = [
          "OC\\Preview\\BMP"
          "OC\\Preview\\GIF"
          "OC\\Preview\\JPEG"
          "OC\\Preview\\Krita"
          "OC\\Preview\\MarkDown"
          "OC\\Preview\\MP3"
          "OC\\Preview\\OpenDocument"
          "OC\\Preview\\PNG"
          "OC\\Preview\\TXT"
          "OC\\Preview\\XBitmap"
          "OC\\Preview\\HEIC"
        ];
      };

      maxUploadSize = "16G";

      phpOptions."realpath_cache_size" = "0";
      poolSettings = {
        pm = "dynamic";
        "pm.max_children" = 120;
        "pm.start_servers" = 12;
        "pm.min_spare_servers" = 6;
        "pm.max_spare_servers" = 18;
        "pm.max_requests" = 500;
      };

      autoUpdateApps.enable = true;
      appstoreEnable = true;
      extraAppsEnable = true;
      extraApps = let
        version = lib.versions.major config.services.nextcloud.package.version;
        info = builtins.fromJSON (builtins.readFile "${inputs.nc4nix}/${version}.json");
        getInfo = package: {
          inherit (info.${package}) hash url description homepage;
          appName = package;
          appVersion = info.${package}.version;
          license = let
            licenses = {agpl = "agpl3Only";};
            originalLincense = builtins.head info.${package}.licenses;
          in
            licenses.${originalLincense} or originalLincense;
        };
      in
        builtins.listToAttrs (builtins.map (package: {
            name = package;
            value = pkgs.fetchNextcloudApp (getInfo package);
          }) [
            "twofactor_webauthn"
            "calendar"
            "richdocuments"
            "contacts"
            "notes"
            "tasks"
            "news"
          ]);
      caching = {
        redis = true;
        memcached = true;
      };
    };
    redis.servers.nextcloud = {
      enable = true;
      bind = "::1";
      port = 6379;
    };
    nginx.virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      enableACME = true;
    };
  };
  sops.secrets.nextcloud-admin-password = {
    mode = "0666";
    owner = "nextcloud";
    group = "nextcloud";
  };
  networking.firewall.allowedTCPPorts = [80 443];
  systemd.services."nextcloud-setup" = {
    requires = ["mysql.service"];
    after = ["mysql.service"];
  };
}
