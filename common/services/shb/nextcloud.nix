{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) optionals optionalAttrs;
  inherit (config.me) domain;
in {
  options = {me.domain = lib.mkOption {type = lib.types.str;};};

  config = lib.mkMerge [
    (optionalAttrs true {
      shb.zfs.datasets."safe/nextcloud".path = "/var/lib/nextcloud";
      shb.zfs.datasets."safe/redis-nextcloud".path = "/var/lib/redis-nextcloud";
      shb.zfs.datasets."nextcloud" = {
        poolName = "zdata";
        path = "/srv/nextcloud/data";
      };
      shb.user.nextcloud.uid = 10020;

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["n.${domain}"];
      shb.nextcloud = {
        enable = true;
        debug = false;
        inherit domain;
        subdomain = "n";
        ssl = config.shb.certs.certs.letsencrypt.${domain};
        defaultPhoneRegion = "US";

        version = 29;
        dataDir = "/var/lib/nextcloud";
        adminPass.result = config.shb.sops.secret."nextcloud/adminpass".result;
        apps = {
          previewgenerator.enable = true;
          externalStorage = {
            enable = true;
            userLocalMount.directory = "/srv/nextcloud/data/$user/files";
            userLocalMount.mountName = "/";
          };
          ldap = {
            enable = true;
            host = "127.0.0.1";
            port = config.shb.ldap.ldapPort;
            dcdomain = config.shb.ldap.dcdomain;
            adminName = "admin";
            adminPassword.result = config.shb.sops.secret."nextcloud/ldap_admin_password".result;
            userGroup = "nextcloud_user";
          };
          sso = {
            enable = true;
            endpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
            clientID = "nextcloud";

            secret.result = config.shb.sops.secret."nextcloud/sso/secret".result;
            secretForAuthelia.result = config.shb.sops.secret."authelia/nextcloud_sso_secret".result;

            fallbackDefaultAuth = false;
          };
        };
        extraApps = apps: {
          inherit
            (apps)
            bookmarks
            calendar
            contacts
            groupfolders
            mail
            ;
        };
        postgresSettings = {
          # From https://pgtune.leopard.in.ua/ with:

          # DB Version: 14
          # OS Type: linux
          # DB Type: dw
          # Total Memory (RAM): 12 GB
          # CPUs num: 4
          # Connections num: <none>
          # Data Storage: ssd

          max_connections = "400";
          shared_buffers = "3GB";
          effective_cache_size = "9GB";
          maintenance_work_mem = "768MB";
          checkpoint_completion_target = "0.9";
          wal_buffers = "16MB";
          default_statistics_target = "100";
          random_page_cost = "1.1";
          effective_io_concurrency = "200";
          work_mem = "7864kB";
          huge_pages = "off";
          min_wal_size = "1GB";
          max_wal_size = "4GB";
          max_worker_processes = "4";
          max_parallel_workers_per_gather = "2";
          max_parallel_workers = "4";
          max_parallel_maintenance_workers = "2";
        };
        # Chose static and small number of children to avoid too much I/O strain on hard drives.
        phpFpmPoolSettings = {
          "pm" = "static";
          "pm.max_children" = 150;
        };
      };
      systemd.services.postgresql.serviceConfig.Restart = "always";
      # Secret needed for services.nextcloud.config.adminpassFile.
      shb.sops.secret."nextcloud/adminpass" = {
        request = config.shb.nextcloud.adminPass.request;
      };
      shb.sops.secret."nextcloud/ldap_admin_password" = {
        request = config.shb.nextcloud.apps.ldap.adminPassword.request;
        settings.key = "ldap/user_password";
      };

      shb.sops.secret."nextcloud/sso/secret" = {
        request = config.shb.nextcloud.apps.sso.secret.request;
      };
      shb.sops.secret."authelia/nextcloud_sso_secret" = {
        request = config.shb.nextcloud.apps.sso.secretForAuthelia.request;
        settings.key = "nextcloud/sso/secret";
      };
    })
  ];
}
