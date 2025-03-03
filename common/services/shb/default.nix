{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) optionals optionalAttrs;
  # inherit (config.me) domain;
  domain = "nyxer.xyz";

  backupCfg = {
    enable ? true,
    shbOpt ? null,
  }: name: let
    bck =
      if shbOpt != null
      then shbOpt
      else config.shb.${name}.backup.request;
  in {
    shb = {
      restic.instances.${name} = {
        request = bck;
        settings = {
          enable = enable;
          passphrase.result = config.shb.sops.secret."${name}/backup/passphrase".result;
          repository = {
            path = "/srv/backup/restic/skarabox/${name}";
            timerConfig = {
              OnBootSec = "15min";
              OnUnitActiveSec = "1h";
              RandomizedDelaySec = "7min";
            };
          };
          retention = {
            keep_within = "1d";
            keep_hourly = 24;
            keep_daily = 7;
            keep_weekly = 4;
            keep_monthly = 6;
          };
        };
      };
      sops.secret = {
        "${name}/backup/passphrase" = {
          request = config.shb.restic.instances.${name}.settings.passphrase.request;
        };
        "${name}/backup/b2_access_key_id" = {
          request = config.shb.restic.instances.${name}.settings.passphrase.request;
          settings.key = "backup/b2/access_key_id";
        };
        "${name}/backup/b2_secret_access_key" = {
          request = config.shb.restic.instances.${name}.settings.passphrase.request;
          settings.key = "backup/b2/secret_access_key";
        };
      };
    };
  };
in {
  imports = [./arr.nix];
  options = {me.domain = lib.mkOption {type = lib.types.str;};};

  config = lib.mkMerge [
    {
      shb.zfs.defaultPoolName = "root";
      sops.defaultSopsFile = ./secrets.yaml;
    }
    {
      services.openssh.listenAddresses = [
        {
          addr = "0.0.0.0"; # Needs to be 0.0.0.0 otherwise it cannot bind on boot.
          port = 22;
        }
        {
          addr = "0.0.0.0";
          port = 2222;
        }
      ];
      networking.firewall.allowedTCPPorts = [2222];
    }
    {
      networking.firewall.allowedUDPPorts = [53];
      services.dnsmasq = {
        enable = true;
        settings = {
          # When switching DNS server, accept old leases from previous server.
          dhcp-authoritative = true;
          dhcp-range = "192.168.1.101,192.168.1.150,255.255.255.0,6h";
          dhcp-host = ["aa:bb:cc:dd:ee:ff,skarabox,192.168.1.30,infinite"];
          dhcp-option = ["3,192.168.1.1"];
          server = [
            # Stubby
            # Also https://wiki.archlinux.org/title/Stubby#Change_port
            "127.0.0.1#53000"
            "::1#53000"
          ];
          log-queries = false;
          # For stubby
          proxy-dnssec = true;
          inherit domain;
          no-resolv = true;
          bogus-priv = true;
          strict-order = true;
          # Got issues with bind-interface on startup, needing to restart dnsmasq for it to listen correctly.
          # bind-interfaces = true;
          # add-cpe-id = 858972;
          address =
            (map (hostname: "/${hostname}.${domain}/192.168.1.30") [
              "authelia"
              "ldap"

              "forgejo"
              "grafana"
              "ha"
              "hledger"
              "jellyfin"
              "n"
              "vaultwarden"

              "deluge"
              "radarr"
              "sonarr"
              "jackett"
            ])
            ++ (map (hostname: "/${hostname}.${domain}/192.168.1.1") [
              "router"
            ]);
        };
      };

      services.stubby = {
        enable = true;
        # https://github.com/getdnsapi/stubby/blob/develop/stubby.yml.example
        settings =
          pkgs.stubby.passthru.settingsExample
          // {
            listen_addresses = ["127.0.0.1@53000" "0::1@53000"];
            # https://dnsprivacy.org/public_resolvers/
            # digest from https://nixos.wiki/wiki/Encrypted_DNS#Stubby
            upstream_recursive_servers = [
              {
                address_data = "9.9.9.9";
                tls_auth_name = "dns.quad9.net";
                tls_pubkey_pinset = [
                  {
                    digest = "sha256";
                    value = "i2kObfz0qIKCGNWt7MjBUeSrh0Dyjb0/zWINImZES+I=";
                  }
                ];
              }
              {
                address_data = "149.112.112.112";
                tls_auth_name = "dns.quad9.net";
                tls_pubkey_pinset = [
                  {
                    digest = "sha256";
                    value = "i2kObfz0qIKCGNWt7MjBUeSrh0Dyjb0/zWINImZES+I=";
                  }
                ];
              }
            ];
          };
      };
    }
    {
      services.nginx.enable = true;
      shb.nginx.accessLog = true;
      networking.firewall.allowedTCPPorts = [80 443];

      # Need to wait on auth endpoint to be available otherwise nginx can fail to start.
      systemd.services.nginx = {
        wants = optionals config.services.dnsmasq.enable ["dnsmasq.service"];
        after = optionals config.services.dnsmasq.enable ["dnsmasq.service"];
      };
    }
    (optionalAttrs true (backupCfg {} "forgejo"))
    (optionalAttrs true (backupCfg {} "vaultwarden"))
    (optionalAttrs true (backupCfg {} "nextcloud"))
    (optionalAttrs true (backupCfg {
      shbOpt = {
        user = "nextcloud";
        sourceDirectories = [
          "/srv/nextcloud/data"
        ];
      };
    } "nextcloud-data"))
    (backupCfg {
      shbOpt = {
        user = "root";
        sourceDirectories = ["/var/lib/private/lldap/"];
      };
    } "ldap")
    (backupCfg {} "jellyfin")
    (backupCfg {} "home-assistant")
    (backupCfg {} "hledger")
    (backupCfg {} "deluge")
    (backupCfg {shbOpt = config.shb.arr.radarr;} "radarr")
    (backupCfg {shbOpt = config.shb.arr.sonarr;} "sonarr")
    (backupCfg {shbOpt = config.shb.arr.jackett;} "jackett")
  ];
}
