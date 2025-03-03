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
      shb.user.hledger.uid = 990;

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["hledger.${domain}"];
      shb.hledger = {
        enable = true;
        inherit domain;
        subdomain = "hledger";
        ssl = config.shb.certs.certs.letsencrypt.${domain};
        authEndpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
        localNetworkIPRange = "192.168.1.0/24";
      };

      shb.zfs.datasets."safe/hledger".path = "/var/lib/hledger";
    })
  ];
}
