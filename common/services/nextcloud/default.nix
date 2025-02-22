{
  self,
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  host = "nextcloud.nyxer.xyz";
in {
  imports = [./nextcloud-extras.nix];

  environment.etc."nextcloud-user-pass".text = "PWD";
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud30;

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
          "www.nyxer.xyz"
          "nyxer.xyz"
          "top"
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
          # "OC\\Preview\\PDF"
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
      ensureUsers = {
        nyx = {
          email = "nxyerproject@gmail.com";
          passwordFile = "/var/run/secrets/nextcloud-nyx-password";
        };
        test = {
          email = "nxyerproject@gmail.com";
          passwordFile = "/var/run/secrets/nextcloud-nyx-password";
        };
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
            "maps"
            "phonetrack"
            "twofactor_webauthn"
            "calendar"
            "richdocuments"
            "contacts"
            "money"
            "notes"
            "tasks"
            "news"
            "external"
            "cookbook"
          ]);
      caching = {
        redis = true;
        memcached = true;
      };
    };

    # Set up Redis because the admin page was complaining about it.
    # https://discourse.nixos.org/t/nextlcoud-with-redis-distributed-cashing-and-file-locking/25321/3
    # redis.servers.nextcloud = {
    #   enable = true;
    #   bind = "::1";
    #   port = 6379;
    # };

    nginx.virtualHosts.${config.services.nextcloud.hostName} = {
      forceSSL = true;
      enableACME = true;
    };

    # phpfpm = {
    #   enable = true;
    #   pools.nextcloud = {
    #     user = "nextcloud";
    #     group = "nextcloud";
    #     settings = {
    #       "listen.owner" = config.services.nginx.user;
    #       "listen.group" = config.services.nginx.group;
    #     };
    #     phpEnv = {
    #       NEXTCLOUD_CONFIG_DIR = "var/lib/nextcloud/config";
    #       PATH = "/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/usr/bin:/bin";
    #     };
    #   };
    # };
  };
  security.acme = {
    acceptTerms = true;
    certs = {
      ${config.services.nextcloud.hostName}.email = "your-letsencrypt-email@example.com";
    };
  };
  sops.secrets = {
    nextcloud-admin-password = {
      mode = "0666";
      owner = "nextcloud";
      group = "nextcloud";
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];

  systemd.services."nextcloud-setup" = {
    requires = ["mysql.service"];
    after = ["mysql.service"];
  };
}
