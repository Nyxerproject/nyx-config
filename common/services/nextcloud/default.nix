{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  host = "nextcloud.nyxer.xyz";
  backup-name = "restic";
in {
  # Set up the user in case you need consistent UIDs and GIDs. And also to make
  # sure we can write out the secrets file with the proper permissions.
  users.groups.nextcloud = {};
  users.users.nextcloud = {
    isSystemUser = true;
    group = "nextcloud";
  };

  environment.etc."nextcloud-admin-pass".text = "PWD";

  services = {
    # Set up Nextcloud.

    nextcloud = {
      enable = true;
      package = pkgs.nextcloud30;
      https = true;
      hostName = host;
      secretFile = "/var/run/secrets/nextcloud-secrets";

      /*
      phpOptions."opcache.interned_strings_buffer" = "13";
      */
      # WARN: is this needed?

      config = {
        dbtype = "mysql";
        dbname = "nextcloud";
        dbhost = "localhost";
        dbpassFile = "/var/run/secrets/nextcloud-db-password";

        adminuser = "admin";
        adminpassFile = "/var/run/secrets/nextcloud-admin-password";
      };

      settings = {
        maintenance_window_start = 2; # maintenance down-time window: 02:00
        default_phone_region = "en";
        filelocking.enabled = true;
        # TODO: Find what this is and if it is needed

        redis = {
          host = config.services.redis.servers.nextcloud.bind;
          port = config.services.redis.servers.nextcloud.port;
          dbindex = 0;
          timeout = 1.5;
        };
      };

      /*
         caching = {
        redis = true;
        memcached = true;
      };
      */
      # TODO: Uncomment this later after understanding more about it
    };

    # Set up backing up the database automatically. The path will be in
    # `/var/backups/mysql/nextcloud.gz`.
    mysqlBackup.databases = ["nextcloud"];

    # Restic is already set up to back up the mysql directory but
    # we also set it up to backup the data.
    #restic.backups.${backup-name}.paths = ["/var/lib/nextcloud/data"];

    # Set up Redis because the admin page was complaining about it.
    # https://discourse.nixos.org/t/nextlcoud-with-redis-distributed-cashing-and-file-locking/25321/3
    redis.servers.nextcloud = {
      enable = true;
      bind = "::1";
      port = 6379;
    };

    # Setup Nginx because we have multiple services on this server.
    nginx = {
      enable = true;
      virtualHosts."${host}" = {
        forceSSL = true;
        enableACME = true;
      };
    };
  };

  # Set up secrets. This is a sops-nix file checked in at the same folder as
  # this file.

  sops.secrets = {
    nextcloud-admin-password = {
      # nextcloud/adminpass = {
      # sopsFile = ./secrets.yaml;
      # NOTE: by default, its all in one file in security.
      # TODO: add secrets file here.
      mode = "0666";
      owner = "nextcloud";
      group = "nextcloud";
    };

    nextcloud-db-password = {
      # sopsFile = ./secrets.yaml;
      mode = "0666";
      owner = "nextcloud";
      group = "nextcloud";
    };

    nextcloud-secrets = {
      # sopsFile = ./secrets.yaml;
      mode = "0666";
      owner = "nextcloud";
      group = "nextcloud";
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
