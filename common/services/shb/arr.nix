{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionals optionalAttrs;
  inherit (config.me) domain;
in
{
  imports = [
    ./ssl.nix
    ./sso.nix
  ];
  options = {
    me.domain = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkMerge [
    (optionalAttrs true {
      shb = {
        user = {
          radarr.uid = 10010;
          radarr.extraGroups = [ "media" ];
          sonarr.uid = 10011;
          sonarr.extraGroups = [ "media" ];
          jackett.uid = 10015;
        };

        certs.certs.letsencrypt.${domain}.extraDomains = [
          "moviesdl.${domain}"
          "seriesdl.${domain}"
          "subtitlesdl.${domain}"
          "booksdl.${domain}"
          "musicdl.${domain}"
          "indexer.${domain}"
        ];
        arr = {
          radarr = {
            subdomain = "radarr";
            inherit domain;
            enable = true;
            ssl = config.shb.certs.certs.letsencrypt.${domain};
            authEndpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
            settings = {
              ApiKey.source = config.shb.sops.secret."radarr/apikey".result.path;
            };
          };
          sonarr = {
            subdomain = "sonarr";
            inherit domain;
            enable = true;
            ssl = config.shb.certs.certs.letsencrypt."${domain}";
            authEndpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
            settings = {
              ApiKey.source = config.shb.sops.secret."sonarr/apikey".result.path;
            };
          };
          jackett = {
            subdomain = "jackett";
            inherit domain;
            enable = true;
            ssl = config.shb.certs.certs.letsencrypt."${domain}";
            authEndpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
            settings = {
              ApiKey.source = config.shb.sops.secret."jackett/apikey".result.path;
              ProxyType = "0";
              ProxyUrl = "127.0.0.1:${toString config.shb.vpn.nordvpnfr.proxyPort}";
            };
          };
        };
        sops.secret = {
          "radarr/apikey".request = {
            mode = "0440";
            owner = "radarr";
            group = "radarr";
            restartUnits = [ "radarr.service" ];
          };
          "sonarr/apikey".request = {
            mode = "0440";
            owner = "sonarr";
            group = "sonarr";
            restartUnits = [ "sonarr.service" ];
          };
          "jackett/apikey".request = {
            mode = "0440";
            owner = "jackett";
            group = "jackett";
            restartUnits = [ "jackett.service" ];
          };
        };

        zfs.datasets = {
          "safe/radarr".path = "/var/lib/radarr";
          "safe/sonarr".path = "/var/lib/sonarr";
          "safe/jackett".path = "/var/lib/jackett";
        };
      };
    })
  ];
}
