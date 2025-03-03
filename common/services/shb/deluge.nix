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
      shb.vpn.nordvpnfr = {
        enable = true;
        provider = "nordvpn";
        dev = "tun2";
        routingNumber = 11;
        remoteServerIP = "One of the servers";
        authFile = config.shb.sops.secret."nordvpnfr/auth".result.path;
        proxyPort = 12001;
      };
      shb.sops.secret."nordvpnfr/auth".request = {
        mode = "0440";
        restartUnits = ["openvpn-nordvpnfr.service"];
      };

      shb.user.deluge.uid = 10001;

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["deluge.${domain}"];
      shb.deluge = {
        enable = true;
        inherit domain;
        subdomain = "deluge";
        ssl = config.shb.certs.certs.letsencrypt.${domain};

        daemonPort = 58846;
        daemonListenPorts = [6881 6889];
        webPort = 8112;
        # Some things do not work with the proxy, so instead bind to the interface directly
        # proxyPort = config.shb.vpn.nordvpnus.proxyPort;
        outgoingInterface = config.shb.vpn.nordvpnfr.dev;
        authEndpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
        localclientPassword.result = config.shb.sops.secret."deluge/auth/localclient".result;
        extraUsers = {
          ibizaman.password.source = config.shb.sops.secret."deluge/auth/ibizaman".result.path;
        };
        prometheusScraperPassword.result = config.shb.sops.secret."deluge/auth/prometheus".result;
        settings = {
          downloadLocation = "/srv/downloads";
        };
        extraServiceConfig = {
          MemoryHigh = "5G";
          MemoryMax = "6G";
        };
        logLevel = "info";
      };
      shb.sops.secret."deluge/auth/localclient".request = config.shb.deluge.localclientPassword.request;
      shb.sops.secret."deluge/auth/ibizaman".request = {
        mode = "0440";
        owner = config.services.deluge.user;
        group = config.services.deluge.group;
        restartUnits = ["deluged.service" "delugeweb.service"];
      };
      shb.sops.secret."deluge/auth/prometheus".request = config.shb.deluge.prometheusScraperPassword.request;

      shb.zfs.datasets."safe/deluge".path = "/var/lib/deluge";
    })
  ];
}
